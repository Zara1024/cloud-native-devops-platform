#!/bin/bash
set -o pipefail

setup_hosts() {
    sudo sed -i '/${domain}/d' /etc/hosts 2>/dev/null || true
    echo "${public_ip} gitlab.${domain}" | sudo tee -a /etc/hosts
    echo "${public_ip} harbor.${domain}" | sudo tee -a /etc/hosts
    echo "${public_ip} nexus.${domain}" | sudo tee -a /etc/hosts
    echo "${public_ip} jenkins.${domain}" | sudo tee -a /etc/hosts
    echo "${public_ip} sonar.${domain}" | sudo tee -a /etc/hosts
    echo "${public_ip} argocd.${domain}" | sudo tee -a /etc/hosts
    echo "${public_ip} grafana.${domain}" | sudo tee -a /etc/hosts
    echo "${public_ip} prometheus.${domain}" | sudo tee -a /etc/hosts
}

setup_cli() {
    sudo wget -q https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/bin/yq && sudo chmod +x /usr/bin/yq
    curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
    # 安装 postgresql 客户端与 git
    sudo apt-get update -y
    sudo apt-get -y install postgresql-client git nfs-common || {
        sudo install -d /etc/apt/keyrings
        curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo gpg --dearmor -o /etc/apt/keyrings/postgresql.gpg --yes
        echo "deb [signed-by=/etc/apt/keyrings/postgresql.gpg] http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" | sudo tee /etc/apt/sources.list.d/pgdg.list
        sudo apt-get update -y
        sudo apt-get -y install postgresql-client git nfs-common
    }
    git config --global user.email "admin@${domain}"
    git config --global user.name "root"
}

# 宿主机合设运行 PostgreSQL 14 并自动初始化 K3s 与 Harbor 双数据库
setup_local_postgres() {
    echo "=== [1/8] 初始化宿主机合设 PostgreSQL 数据库服务 ==="
    # 确保宿主机安装 Docker
    if ! command -v docker &> /dev/null; then
        sudo NEEDRESTART_MODE=a apt-get update -y
        sudo NEEDRESTART_MODE=a apt-get install -y ca-certificates curl gnupg
        sudo install -m 0755 -d /etc/apt/keyrings
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg --yes
        sudo chmod a+r /etc/apt/keyrings/docker.gpg
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
        sudo NEEDRESTART_MODE=a apt-get update -y
        sudo NEEDRESTART_MODE=a apt-get install -y docker-ce docker-ce-cli containerd.io
    fi

    sudo mkdir -p /data/postgresql
    if ! sudo docker ps | grep -q "local-postgres"; then
        sudo docker run -d --name local-postgres \
            --restart always \
            -p 5432:5432 \
            -v /data/postgresql:/var/lib/postgresql/data \
            -e POSTGRES_PASSWORD="${pg_password}" \
            postgres:14.2
    fi

    until PGPASSWORD="${pg_password}" psql -h 127.0.0.1 -U postgres -c '\q' 2>/dev/null; do
        echo "等待宿主机 PostgreSQL 启动就绪..."
        sleep 1
    done

    # 预建 K3s 底座库 (kubernetes) 与 Harbor 专属库 (registry)
    PGPASSWORD="${pg_password}" psql -h 127.0.0.1 -U postgres << 'EOF'
DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = 'k3s') THEN
        CREATE USER k3s WITH ENCRYPTED PASSWORD '${pg_password}';
    END IF;
    IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = 'harbor') THEN
        CREATE USER harbor WITH ENCRYPTED PASSWORD '${harbor_password}';
    END IF;
END
$$;
SELECT 'CREATE DATABASE kubernetes OWNER k3s' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'kubernetes')\gexec
GRANT ALL PRIVILEGES ON DATABASE kubernetes TO k3s;
SELECT 'CREATE DATABASE registry OWNER harbor' WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'registry')\gexec
GRANT ALL PRIVILEGES ON DATABASE registry TO harbor;
EOF
    echo "PostgreSQL 双库预初始化成功！"
}

# 部署腾讯云 CFS 驱动并自动注册支持 ReadWriteMany 的 StorageClass
setup_cfs_storageclass() {
    echo "=== [2/8] 部署腾讯云 CFS 驱动并注册 ReadWriteMany 存储类 (cfs-rwx) ==="
    helm repo add nfs-subdir-external-provisioner https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner/ || true
    helm repo update

    helm upgrade --install cfs-provisioner nfs-subdir-external-provisioner/nfs-subdir-external-provisioner \
        --namespace kube-system \
        --set nfs.server="${cfs_mount_ip}" \
        --set nfs.path="/" \
        --set storageClass.name="cfs-rwx" \
        --set storageClass.provisionerName="tencentcloud.com/cfs" \
        --set storageClass.accessModes="{ReadWriteMany}" \
        --set storageClass.reclaimPolicy="Retain" \
        --wait --timeout 5m || true

    echo "腾讯云 CFS ReadWriteMany 存储类注册完毕！"
}

# 部署企业级内网 Nexus 制品库 (Maven / npm 私服与代理)
setup_nexus() {
    echo "=== [3/8] 部署内网 Nexus 3 制品库 (Maven / npm 代理加速) ==="
    helm repo add sonatype https://sonatype.github.io/helm3-charts/ || true
    helm repo update
    kubectl create namespace nexus || true

    helm upgrade --install nexus sonatype/nexus-repository-manager \
        --namespace nexus \
        -f /tmp/nexus-values.yaml \
        --wait --timeout 10m || true

    echo "Nexus 制品库部署完成！"
}

setup_k3s() {
    echo "Installing/starting K3s..."
    sudo mkdir -p /etc/rancher/k3s
    cat << EOF | sudo tee /etc/rancher/k3s/registries.yaml
configs:
  "harbor.${domain}":
    tls:
      insecure_skip_verify: true
EOF
    curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --tls-san ${public_ip} --write-kubeconfig-mode 644 --disable=traefik --token=${pg_password} --datastore-endpoint=postgres://k3s:${pg_password}@${pg_ip}:5432/kubernetes" sh -s -

    echo "Waiting for /etc/rancher/k3s/k3s.yaml..."
    until sudo test -f /etc/rancher/k3s/k3s.yaml; do
        sleep 2
    done

    # Ensure permissions for non-root user ubuntu
    sudo chmod 755 /etc/rancher /etc/rancher/k3s
    sudo chmod 644 /etc/rancher/k3s/k3s.yaml
    mkdir -p /home/ubuntu/.kube
    sudo cp /etc/rancher/k3s/k3s.yaml /home/ubuntu/.kube/config
    sudo chown -R ubuntu:ubuntu /home/ubuntu/.kube
    export KUBECONFIG=/home/ubuntu/.kube/config
    grep -q "KUBECONFIG" /home/ubuntu/.bashrc 2>/dev/null || echo 'export KUBECONFIG=/home/ubuntu/.kube/config' >> /home/ubuntu/.bashrc

    sudo ln -sf /usr/local/bin/k3s /usr/local/bin/kubectl 2>/dev/null || true

    echo "Waiting for k3s cluster ready..."
    until kubectl get nodes 2>/dev/null; do
        sleep 2
    done
    kubectl wait --for=condition=Ready nodes --all --timeout=300s
    kubectl wait --for=condition=Ready pod --all -n kube-system --timeout=900s
}

setup_legacy_images() {
    echo "Pre-pulling and tagging legacy Bitnami/MinIO images..."
    sudo k3s ctr --namespace k8s.io images pull docker.io/bitnamilegacy/postgresql:13.6.0 || true
    sudo k3s ctr --namespace k8s.io images tag docker.io/bitnamilegacy/postgresql:13.6.0 docker.io/bitnami/postgresql:13.6.0 || true
    sudo k3s ctr --namespace k8s.io images tag docker.io/bitnamilegacy/postgresql:13.6.0 docker.io/bitnami/postgresql:11.14.0-debian-10-r22 || true
    sudo k3s ctr --namespace k8s.io images pull docker.io/bitnamilegacy/redis:6.2.7-debian-11-r11 || true
    sudo k3s ctr --namespace k8s.io images tag docker.io/bitnamilegacy/redis:6.2.7-debian-11-r11 docker.io/bitnami/redis:6.2.7-debian-11-r11 || true
    sudo k3s ctr --namespace k8s.io images pull docker.io/bitnamilegacy/postgres-exporter:0.12.0-debian-11-r86 || true
    sudo k3s ctr --namespace k8s.io images tag docker.io/bitnamilegacy/postgres-exporter:0.12.0-debian-11-r86 docker.io/bitnami/postgres-exporter:0.12.0-debian-11-r86 || true
    sudo k3s ctr --namespace k8s.io images pull docker.io/bitnamilegacy/redis-exporter:1.43.0-debian-11-r4 || true
    sudo k3s ctr --namespace k8s.io images tag docker.io/bitnamilegacy/redis-exporter:1.43.0-debian-11-r4 docker.io/bitnami/redis-exporter:1.43.0-debian-11-r4 || true
    sudo k3s ctr --namespace k8s.io images pull docker.io/bitnamilegacy/minio:2022.6.20-debian-11-r0 || true
    sudo k3s ctr --namespace k8s.io images tag docker.io/bitnamilegacy/minio:2022.6.20-debian-11-r0 docker.io/minio/minio:RELEASE.2017-12-28T01-21-00Z || true
}

setup_helm_repo() {
    helm repo add grafana https://grafana.github.io/helm-charts
    helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
    helm repo add gitlab https://charts.gitlab.io/
    helm repo add harbor https://helm.goharbor.io
    helm repo add sonarqube https://SonarSource.github.io/helm-chart-sonarqube
    helm repo add jenkins https://charts.jenkins.io
    helm repo add argo https://argoproj.github.io/argo-helm
    helm repo update
}

setup_kube_prometheus_grafana_loki() {
    helm upgrade -i loki -n monitoring --create-namespace grafana/loki-stack --set loki.isDefault=false
    helm upgrade -i kube-prometheus-stack -n monitoring --create-namespace prometheus-community/kube-prometheus-stack -f /tmp/kube-prometheus-stack-values.yaml
}

setup_gitlab() {
    helm upgrade --install gitlab gitlab/gitlab \
    --timeout 600s \
    --set global.hosts.domain=${domain} \
    --set global.hosts.externalIP=${public_ip} \
    --set certmanager-issuer.email=admin@${domain} \
    --set postgresql.image.tag="13.6.0" \
    --set global.edition=ce \
    --set global.shell.port=2222 \
    --set nginx-ingress.controller.scope.enabled=false \
    --version "7.0.4" \
    --set gitlab-runner.gitlabUrl=http://gitlab-webservice-default:8181 \
    -n gitlab --create-namespace

    # Apply cert-manager-secret and issuer
    kubectl apply -f /tmp/cert-manager-cloudflare-secret.yaml -n gitlab
    kubectl apply -f /tmp/issuer.yaml

    echo "Waiting for gitlab deployment object..."
    until kubectl get deployment gitlab-webservice-default -n gitlab >/dev/null 2>&1; do
        sleep 2
    done
    kubectl wait --for=condition=Available deployment/gitlab-webservice-default -n gitlab --timeout=900s

    # patch gitlab-minio for Bitnami image entrypoint compatibility
    if kubectl get deployment gitlab-minio -n gitlab >/dev/null 2>&1; then
        cat << 'EOF' > /tmp/minio-patch.yaml
spec:
  template:
    spec:
      containers:
      - name: minio
        command:
        - /opt/bitnami/minio/bin/minio
        - server
        - /export
        - --address
        - :9000
        - --console-address
        - :9001
        args: []
EOF
        kubectl patch deployment -n gitlab gitlab-minio --patch-file /tmp/minio-patch.yaml 2>/dev/null || true
    fi

    echo "Waiting for gitlab ready"
    until curl -sSf -k "${gitlab_host}" >/dev/null 2>&1; do
        sleep 2
    done

    gitlab_root_password=$(kubectl get secret gitlab-gitlab-initial-root-password -ojsonpath='{.data.password}' -n gitlab | base64 --decode ; echo)
    echo "GitLab password: "$gitlab_root_password

    # Allow Jenkins and internal tools to access GitLab via HTTP without 308 SSL redirect
    kubectl annotate ingress -n gitlab gitlab-webservice-default nginx.ingress.kubernetes.io/ssl-redirect='false' --overwrite || true


    echo "Begin to create GitLab PAT and Project"
    # Create GitLab PAT
    gitlab_user="root"

    # 1. curl for the login page to get a session cookie and the sources with the auth tokens
    body_header=$(curl -c cookies.txt -i "${gitlab_host}/users/sign_in" -s --insecure)
    # grep the auth token for the user login for
    csrf_token=$(echo $body_header | perl -ne 'print "$1\n" if /new_user.*?authenticity_token"[[:blank:]]value="(.+?)"/' | sed -n 1p)
    # 2. send login credentials with curl, using cookies and token from previous request
    curl -L -b cookies.txt -c cookies.txt -i "${gitlab_host}/users/sign_in" \
    --data-raw "user%5Blogin%5D=$gitlab_user&user%5Bpassword%5D=$gitlab_root_password" \
    --data-urlencode "authenticity_token=$csrf_token" \
    --compressed \
    --insecure 2>&1 > /dev/null

    # 3. send curl GET request to personal access token page to get auth token
    body_header=$(curl -H 'user-agent: curl' -b cookies.txt -i "${gitlab_host}/-/profile/personal_access_tokens" -s --insecure)

    csrf_token=$(echo $body_header | perl -ne 'print "$1\n" if /csrf-token"[[:blank:]]content="(.+?)"/' | sed -n 1p)
    # 4. curl POST request to send the "generate personal access token form"
    body_header=$(curl --insecure -L -b cookies.txt "${gitlab_host}/-/profile/personal_access_tokens" \
        --data-urlencode "authenticity_token=$csrf_token" \
        --data 'personal_access_token[name]=golab-generated&personal_access_token[expires_at]=&personal_access_token[scopes][]=api&personal_access_token[scopes][]=read_repository&personal_access_token[scopes][]=write_repository&personal_access_token[scopes][]=sudo' --insecure)
    # 5. Scrape the personal access token from the response json
    personal_access_token=$(echo $body_header | perl -ne 'print "$1\n" if /new_token":"(.+?)"/' | sed -n 1p)
    echo "GitLab personal access token: "$personal_access_token

    if [ -z "$personal_access_token" ]; then
      echo "Web scraping returned empty token, attempting to generate GitLab PAT via gitlab-rails..."
      toolbox_pod=$(kubectl get pod -n gitlab -l app=toolbox -o jsonpath='{.items[0].metadata.name}' 2>/dev/null || kubectl get pod -n gitlab -l app=webservice -o jsonpath='{.items[0].metadata.name}')
      if [ -n "$toolbox_pod" ]; then
        personal_access_token="glpat-$(openssl rand -hex 10)"
        kubectl exec -n gitlab "$toolbox_pod" -c toolbox -- gitlab-rails runner "user = User.find_by_username('root'); token = user.personal_access_tokens.create(scopes: ['api', 'read_repository', 'write_repository', 'sudo'], name: 'devops-auto-token'); token.set_token('$personal_access_token'); token.save!" 2>/dev/null || \
        kubectl exec -n gitlab "$toolbox_pod" -- gitlab-rails runner "user = User.find_by_username('root'); token = user.personal_access_tokens.create(scopes: ['api', 'read_repository', 'write_repository', 'sudo'], name: 'devops-auto-token'); token.set_token('$personal_access_token'); token.save!" 2>/dev/null
        echo "GitLab personal access token (via rails): "$personal_access_token
      fi
    fi

    if [ -z "$personal_access_token" ]; then
      echo "GitLab personal access token is empty, exit."
      exit 1
    fi
}

setup_gitlab_project() {
    cd /home/ubuntu
    mkdir -p /home/ubuntu/workspace
    cd /home/ubuntu/workspace

    ################################ create camp-go-exmaple project and push source code from github ############################
    project_response=$(curl -s -I --request GET --header "PRIVATE-TOKEN: $personal_access_token" "https://gitlab.${domain}/api/v4/projects/1" --insecure)
    echo "Project response: "$project_response

    if echo "$project_response" | grep -q "404"; then
        echo "Project 1 not found, create."
        # Create GitLab Project
        curl --request POST --header "PRIVATE-TOKEN: $personal_access_token" \
        --header "Content-Type: application/json" --data '{
        "name": "${example_project_name}", "description": "GeekTime Cloud Native DevOps Camp", "path": "${example_project_name}", "initialize_with_readme": "false", "only_allow_merge_if_pipeline_succeeds": "true"}' \
        --url "https://gitlab.${domain}/api/v4/projects/" --insecure
        
        rm -rf ${example_project_name}
        git clone https://github.com/lyzhang1999/${example_project_name}.git
        cd ${example_project_name}
        # Fix Grype vulnerability database expiration limit
        sed -i 's|grype /home/jenkins/agent/image.tar --fail-on critical|GRYPE_DB_MAX_ALLOWED_BUILT_AGE=87600h GRYPE_DB_AUTO_UPDATE=false grype /home/jenkins/agent/image.tar --fail-on critical|g' Jenkinsfile
        # Fix Cosign sign insecure registry support and loop delay
        sed -i 's|cosign sign --key /root/cosign.key|cosign sign --allow-insecure-registry=true --key /root/cosign.key|g' Jenkinsfile
        sed -i 's|echo "Waiting for harbor scan image"|echo "Waiting for harbor scan image"; sleep 2|g' Jenkinsfile
        git remote set-url origin https://root:$personal_access_token@gitlab.${domain}/root/${example_project_name}.git
        git add .
        git commit -a -m 'Initial' || true
        # push main and dev branch
        GIT_SSL_NO_VERIFY=true git push -uf origin main && GIT_SSL_NO_VERIFY=true git push -uf origin main:dev
        # Delete branch protection
        curl --insecure --request DELETE --header "PRIVATE-TOKEN: $personal_access_token" "https://gitlab.${domain}/api/v4/projects/1/protected_branches/main"
        cd /home/ubuntu/workspace
    fi

    ############################ create camp-go-exmaple-helm project and push source code from github ################################
    project_response=$(curl -s -I --request GET --header "PRIVATE-TOKEN: $personal_access_token" "https://gitlab.${domain}/api/v4/projects/2" --insecure)
    echo "Project response: "$project_response

    if echo "$project_response" | grep -q "404"; then
        echo "Project 2 not found, create."
        # Create GitLab Project
        curl --request POST --header "PRIVATE-TOKEN: $personal_access_token" \
        --header "Content-Type: application/json" --data '{
        "name": "${example_project_name}-helm", "description": "GeekTime Cloud Native DevOps Camp", "path": "${example_project_name}-helm", "initialize_with_readme": "false"}' \
        --url "https://gitlab.${domain}/api/v4/projects/" --insecure
        
        rm -rf ${example_project_name}-helm
        git clone https://github.com/lyzhang1999/${example_project_name}-helm.git
        cd ${example_project_name}-helm

        yq -i '.image.repository = "harbor.${domain}/${harbor_registry}/${example_project_name}"' charts/env/dev/values.yaml
        yq -i '.image.repository = "harbor.${domain}/${harbor_registry}/${example_project_name}"' charts/env/main/values.yaml

        # generate regcred.yaml in charts/templates/image-pull-secret.yaml for pull image from harbor
        kubectl create secret docker-registry regcred --docker-server=harbor.${domain} --docker-username=admin --docker-password=${harbor_password} -o yaml --dry-run=client > charts/templates/image-pull-secret.yaml

        git remote set-url origin https://root:$personal_access_token@gitlab.${domain}/root/${example_project_name}-helm.git
        git add .
        git commit -a -m 'Initial' || true
        GIT_SSL_NO_VERIFY=true git push -uf origin main
        # Delete branch protection
        curl --insecure --request DELETE --header "PRIVATE-TOKEN: $personal_access_token" "https://gitlab.${domain}/api/v4/projects/2/protected_branches/main"
        cd /home/ubuntu
    fi
}

setup_harbor() {
    kubectl create ns harbor || true
    kubectl apply -f /tmp/harbor-issuer.yaml -n harbor
    
    # create cloudflare secret
    kubectl apply -f /tmp/cert-manager-cloudflare-secret.yaml -n harbor
    # 部署 Harbor (优先采用官方 2.15.0 HA 模式)
    if [ -f /tmp/harbor-ha-values.yaml ]; then
        echo "=== [4/8] 采用 Harbor 官方 2.15.0 高可用模式 (HA) 进行部署 ==="
        helm upgrade --install harbor harbor/harbor -f /tmp/harbor-ha-values.yaml --namespace harbor --create-namespace --wait --timeout 15m
    else
        helm upgrade --install harbor harbor/harbor -f /tmp/harbor-values.yaml --namespace harbor --create-namespace --wait --timeout 15m
    fi

    # deploy harbor dashboard
    kubectl apply -f /tmp/harbor-dashboard.yaml -n harbor

    # wait until harbor pod ready
    echo "Waiting for harbor deployments..."
    until kubectl get deployment -n harbor >/dev/null 2>&1; do
        sleep 2
    done
    kubectl wait deployment -n harbor --for condition=Available=True --all --timeout=900s

    # wait harbor server ready
    echo "Waiting for harbor ready"
    until curl -sSf -k "https://harbor.${domain}" >/dev/null 2>&1; do
        sleep 2
    done

    # wait until default project ready
    echo "Waiting for harbor API healthy..."
    until curl -s -k -u admin:${harbor_password} "https://harbor.${domain}/api/v2.0/health" | grep -q '"status":\s*"healthy"'; do
        sleep 2
    done

    # Add new project if not exists
    echo "Configuring Harbor project: ${harbor_registry}..."
    if ! curl -s -k -u admin:${harbor_password} "https://harbor.${domain}/api/v2.0/projects?name=${harbor_registry}" | grep -q "\"name\":\"${harbor_registry}\""; then
        curl -s -k -X POST "https://harbor.${domain}/api/v2.0/projects" \
        -H 'content-type: application/json' \
        -u admin:${harbor_password} \
        --data-raw '{"project_name":"${harbor_registry}","metadata":{"public":"false"},"storage_limit":-1,"registry_id":null}' \
        --compressed --insecure
    fi

    # Setting project auto_scan and cosign
    proj_id=$(curl -s -k -u admin:${harbor_password} "https://harbor.${domain}/api/v2.0/projects?name=${harbor_registry}" | yq '.[0].project_id' 2>/dev/null || echo "")
    if [ -n "$proj_id" ] && [ "$proj_id" != "null" ]; then
        curl -s -k -X PUT "https://harbor.${domain}/api/v2.0/projects/$proj_id" \
        -H 'content-type: application/json' \
        -u admin:${harbor_password} \
        --data-raw '{"metadata":{"public":"false","enable_content_trust":"false","enable_content_trust_cosign":"false","prevent_vul":"false","severity":"critical","auto_scan":"true","reuse_sys_cve_allowlist":"true"}}' \
        --compressed --insecure || true
    fi
}

setup_sonarqube() {
    helm upgrade --install -n sonarqube sonarqube sonarqube/sonarqube --create-namespace --version 10.1.0+628 -f /tmp/sonarqube-values.yaml

    echo "Waiting for sonarqube pods..."
    until kubectl get pod/sonarqube-postgresql-0 -n sonarqube >/dev/null 2>&1 && kubectl get pod/sonarqube-sonarqube-0 -n sonarqube >/dev/null 2>&1; do
        sleep 2
    done
    kubectl wait --for=condition=Ready pod/sonarqube-postgresql-0 -n sonarqube --timeout=900s
    kubectl wait --for=condition=Ready pod/sonarqube-sonarqube-0 -n sonarqube --timeout=900s

    echo "Waiting for sonar ready"
    until curl -sSf -k "http://sonar.${domain}" >/dev/null 2>&1; do
        sleep 2
    done

    echo "Waiting for SonarQube status UP"
    until curl -s "http://sonar.${domain}/api/system/status" | grep -q '"status":"UP"'; do
        sleep 3
    done

    # create project
    curl --location 'http://sonar.${domain}/api/projects/create' \
    --header 'Content-Type: application/x-www-form-urlencoded' \
    -u admin:${sonar_password} \
    --data-urlencode 'name=${example_project_name}' \
    --data-urlencode 'project=${example_project_name}' --insecure

    # revoke token first
    curl --location 'http://sonar.${domain}/api/user_tokens/revoke' \
    --header 'Content-Type: application/x-www-form-urlencoded' \
    -u admin:${sonar_password} \
    --data-urlencode 'name=${example_project_name}' --insecure

    # generate token again
    sonar_token=$(curl --location 'http://sonar.${domain}/api/user_tokens/generate' \
    --header 'Content-Type: application/x-www-form-urlencoded' \
    -u admin:${sonar_password} \
    --data-urlencode 'name=${example_project_name}' --insecure | yq .token -r)

    sonar_token=$(echo $sonar_token | tr -d '\n')

    # if sonar_token is empty, exit
    if [ -z "$sonar_token" ]; then
        echo "sonar_token create fail, exit."
        exit 1
    fi

    # create secret for jenkins credential to get the sonar token
    cat > /tmp/sonar-token.yaml << EOF
apiVersion: v1
kind: Secret
metadata:
  name: "sonarqube-token"
  namespace: jenkins
  labels:
    "jenkins.io/credentials-type": "secretText"
  annotations:
    "jenkins.io/credentials-description" : "credentials from Kubernetes of Sonarqube"
type: Opaque
stringData:
  text: $sonar_token
EOF
    # apply jenkins ns
    kubectl create ns jenkins || true
    # apply secret
    kubectl apply -f /tmp/sonar-token.yaml -n jenkins

    # create sonar dashboard
    kubectl apply -f /tmp/sonar-dashboard.yaml

    # create sonar jenkins webhooks for enabled quality gate
    curl --location 'http://sonar.${domain}/api/webhooks/create' \
    --header 'Content-Type: application/x-www-form-urlencoded' \
    -u admin:${sonar_password} \
    --data-urlencode 'name=${example_project_name}' \
    --data-urlencode 'url=http://jenkins.${domain}/sonarqube-webhook/' \
    --data-urlencode 'project=${example_project_name}' --insecure
}

setup_jenkins() {
    kubectl create ns jenkins || true
    # as gitlab api secret
    cat > /tmp/gitlab-token.yaml << EOF
apiVersion: v1
kind: Secret
metadata:
  name: "gitlab-token"
  labels:
    "jenkins.io/credentials-type": "gitlabToken"
  annotations:
    "jenkins.io/credentials-description" : "credentials from Kubernetes of GitLab"
type: Opaque
stringData:
  text: $personal_access_token
EOF

    cat > /tmp/jenkins-pvc.yaml << EOF
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: jenkins-workspace-pvc
  namespace: jenkins
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 10Gi
EOF

    # as gitlab pull secret
    cat > /tmp/gitlab-username-password-secret.yaml << EOF
apiVersion: v1
kind: Secret
metadata:
  name: "gitlab-pull-secret"
  labels:
    "jenkins.io/credentials-type": "usernamePassword"
  annotations:
    "jenkins.io/credentials-description" : "credentials from Kubernetes"
type: Opaque
stringData:
  username: root
  password: $personal_access_token
EOF

    setup_cosign

    kubectl apply -f /tmp/gitlab-token.yaml -n jenkins
    kubectl apply -f /tmp/gitlab-username-password-secret.yaml -n jenkins

    # apply jenkins pvc for workspace
    kubectl apply -f /tmp/jenkins-pvc.yaml -n jenkins

    # set harbor url and repository secret, so Jenkinsfile can get it by env
    kubectl apply -f /tmp/jenkins-harbor-url-secret.yaml -n jenkins
    kubectl apply -f /tmp/harbor-repository-secret.yaml -n jenkins

    # plugin need id(url of plugin)
    helm upgrade -i jenkins jenkins/jenkins -n jenkins --create-namespace -f /tmp/jenkins-values.yaml --version 4.6.1
    kubectl apply -f /tmp/jenkins-service-account.yaml -n jenkins

    # apply jenkins dashboard
    kubectl apply -f /tmp/jenkins-dashboard.yaml -n jenkins
    # apply jenkins github pull secret
    kubectl apply -f /tmp/github-pull-secret.yaml -n jenkins
    # apply harbor image pull secret
    kubectl create secret docker-registry regcred --docker-server=harbor.${domain} --docker-username=admin --docker-password=${harbor_password} -n jenkins || true
}

# TODO change file
setup_cosign() {
    kubectl apply -f /tmp/cosign-key-password.yaml -n jenkins
    kubectl apply -f /tmp/cosign-key-file-secret.yaml -n jenkins
}

setup_argocd() {
    helm upgrade --install -n argocd argocd argo/argo-cd --version 5.36.6 -f /tmp/argocd-values.yaml --create-namespace

    # Create repository pull secret
    GITLAB_PERSONAL_TOKEN="$personal_access_token" yq -i '.stringData.url = "https://gitlab.${domain}/root/${example_project_name}-helm.git" | .stringData.password = strenv(GITLAB_PERSONAL_TOKEN) | .stringData.insecure = "true" | .metadata.labels."argocd.argoproj.io/secret-type" = "repository"' /tmp/repo-secret.yaml
    kubectl apply -f /tmp/repo-secret.yaml

    # Create Argo CD ApplicationSet
    yq -i '.spec.generators[0].git.repoURL = "https://gitlab.${domain}/root/${example_project_name}-helm.git" | .spec.template.spec.source.repoURL = "https://gitlab.${domain}/root/${example_project_name}-helm.git" | .spec.template.metadata.annotations."argocd-image-updater.argoproj.io/image-list"="${example_project_name}=harbor.${domain}/${harbor_registry}/${example_project_name}"' /tmp/applicationset.yaml
    kubectl apply -f /tmp/applicationset.yaml

    # setup dashboard
    kubectl apply -f /tmp/argocd-servicemonitor.yaml -n argocd
    kubectl apply -f /tmp/argocd-dashboard.yaml -n argocd
}

setup_argo_image_updater() {
    # install image updater
    kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj-labs/argocd-image-updater/v0.12.2/manifests/install.yaml
    # harbor image pull secret, if you modify the harbor password, you need to update this secret
    kubectl create secret docker-registry regcred --docker-server=harbor.${domain} --docker-username=admin --docker-password=${harbor_password} -n argocd || true
    kubectl apply -f /tmp/argocd-image-updater-config.yaml -n argocd || true

    echo "Waiting for argocd-image-updater deployment..."
    until kubectl get deployment argocd-image-updater -n argocd >/dev/null 2>&1; do
        sleep 2
    done

    # patch argocd image updater command, set interval to 20s instead of 2min
    kubectl patch deployment/argocd-image-updater \
    -n argocd \
    --type=json \
    -p '[{"op": "replace", "path": "/spec/template/spec/containers/0/command", "value": ["/usr/local/bin/argocd-image-updater", "run", "--interval", "20s"]}]' || true
}

output() {
    echo "##################################### Access Infrastructure ########################################"
    echo "Access Grafana: http://grafana.${domain}, admin, ${grafana_password}"
    echo "Access Prometheus: http://prometheus.${domain}"
    echo "Access GitLab: https://gitlab.${domain}, root, $gitlab_root_password, Access Token: $personal_access_token"
    echo "Access Nexus (制品库): http://nexus.${domain}, admin, admin123"
    echo "Access Jenkins: http://jenkins.${domain}, admin, ${jenkins_password}"
    echo "Access Argo CD: http://argocd.${domain}, admin, ${argocd_password}"
    echo "Access Harbor (HA): https://harbor.${domain}, admin, ${harbor_password}"
    echo "Access SonarQube: http://sonar.${domain}, admin, ${sonar_password}"
    echo "Example Application Dev Environment: dev.podinfo.local, Add hosts: ${public_ip} dev.podinfo.local"
    echo "Example Application Prod Environment: prod.podinfo.local, Add hosts: ${public_ip} main.podinfo.local"
    echo "###################################################################################################"
}

main() {
    setup_hosts
    setup_cli
    setup_local_postgres      # [1] 宿主机合设运行 PG 14 并自动预建双库
    setup_k3s                 # [2] 安装 K3s 底座 (连接合设 PG)
    setup_cfs_storageclass    # [3] 注册腾讯云 CFS ReadWriteMany 存储类
    setup_legacy_images
    setup_helm_repo
    setup_kube_prometheus_grafana_loki
    setup_nexus               # [4] 部署内网 Nexus 3 制品库
    setup_gitlab
    setup_gitlab_project
    setup_harbor              # [5] 部署 Harbor 官方 2.15.0 HA 多副本集群
    setup_sonarqube
    setup_jenkins
    setup_argocd
    setup_argo_image_updater
    output
}

main
