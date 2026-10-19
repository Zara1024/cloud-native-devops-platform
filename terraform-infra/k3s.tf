# 移除独立的 PG 虚拟机，改为单台主力主机宿主机合设运行 PostgreSQL 14，节约 50% 成本
resource "null_resource" "connect_ubuntu" {
  depends_on = [
    tencentcloud_instance.ubuntu,
    tencentcloud_cfs_file_system.harbor_cfs
  ]

  connection {
    host     = tencentcloud_instance.ubuntu[0].public_ip
    type     = "ssh"
    user     = "ubuntu"
    password = var.password
  }

  triggers = {
    script_hash = filemd5("${path.module}/init.sh.tpl")
    instance_id = tencentcloud_instance.ubuntu[0].id
  }

  // init.sh 部署引导脚本
  provisioner "file" {
    destination = "/tmp/init.sh"
    content = templatefile(
      "${path.module}/init.sh.tpl",
      {
        "public_ip" : "${tencentcloud_instance.ubuntu[0].public_ip}",
        "domain" : "${var.prefix}.${var.domain}",
        "gitlab_host" : "https://gitlab.${var.prefix}.${var.domain}",
        "harbor_registry" : "${var.registry}",
        "harbor_password" : "${var.harbor_password}",
        "example_project_name" : "${var.example_project_name}",
        "sonar_password" : "${var.sonar_password}",
        "grafana_password" : "${var.grafana_password}",
        "jenkins_password" : "${var.jenkins_password}",
        "argocd_password" : "${var.argocd_password}",
        "pg_ip" : "${tencentcloud_instance.ubuntu[0].private_ip}",
        "pg_password" : "${var.pg_password}",
        "cfs_mount_ip" : "${tencentcloud_cfs_file_system.harbor_cfs.mount_ip}"
      }
    )
  }

  # kube-prometheus-stack
  provisioner "file" {
    destination = "/tmp/kube-prometheus-stack-values.yaml"
    content = templatefile(
      "${path.module}/../platform-manifests/prometheus/values.yaml.tpl",
      {
        "domain" : "${var.prefix}.${var.domain}"
        "grafana_password" : "${var.grafana_password}"
      }
    )
  }

  # jenkins
  provisioner "file" {
    source      = "${path.module}/../platform-manifests/jenkins/dashboard.yaml"
    destination = "/tmp/jenkins-dashboard.yaml"
  }

  provisioner "file" {
    destination = "/tmp/jenkins-values.yaml"
    content = templatefile(
      "${path.module}/../platform-manifests/jenkins/values.yaml.tpl",
      {
        "domain" : "${var.prefix}.${var.domain}"
        "jenkins_password" : "${var.jenkins_password}"
      }
    )
  }

  provisioner "file" {
    destination = "/tmp/jenkins-harbor-url-secret.yaml"
    content = templatefile(
      "${path.module}/../platform-manifests/jenkins/harbor-url-secret.yaml.tpl",
      {
        "domain" : "${var.prefix}.${var.domain}"
      }
    )
  }

  provisioner "file" {
    destination = "/tmp/harbor-repository-secret.yaml"
    content = templatefile(
      "${path.module}/../platform-manifests/jenkins/harbor-repository-secret.yaml.tpl",
      {
        "harbor_registry" : "${var.registry}"
      }
    )
  }

  provisioner "file" {
    source      = "${path.module}/../platform-manifests/jenkins/github-pull-secret.yaml"
    destination = "/tmp/github-pull-secret.yaml"
  }

  provisioner "file" {
    source      = "${path.module}/../platform-manifests/jenkins/service-account.yaml"
    destination = "/tmp/jenkins-service-account.yaml"
  }

  // sonarqube
  provisioner "file" {
    destination = "/tmp/sonarqube-values.yaml"
    content = templatefile(
      "${path.module}/../platform-manifests/sonarqube/values.yaml.tpl",
      {
        "domain" : "${var.prefix}.${var.domain}"
        "sonar_password" : "${var.sonar_password}"
      }
    )
  }

  provisioner "file" {
    source      = "${path.module}/../platform-manifests/sonarqube/sonar-dashboard.yaml"
    destination = "/tmp/sonar-dashboard.yaml"
  }

  // gitlab
  provisioner "file" {
    destination = "/tmp/cert-manager-cloudflare-secret.yaml"
    content = templatefile(
      "${path.module}/../platform-manifests/gitlab/cert-manager-cloudflare-secret.yaml.tpl",
      {
        "api_key" : "${var.cloudflare_api_key}"
      }
    )
  }

  provisioner "file" {
    source      = "${path.module}/../platform-manifests/gitlab/issuer.yaml"
    destination = "/tmp/issuer.yaml"
  }

  # argocd
  provisioner "file" {
    source      = "${path.module}/../platform-manifests/argocd/repo-secret.yaml"
    destination = "/tmp/repo-secret.yaml"
  }

  provisioner "file" {
    source      = "${path.module}/../platform-manifests/argocd/applicationset.yaml"
    destination = "/tmp/applicationset.yaml"
  }

  provisioner "file" {
    source      = "${path.module}/../platform-manifests/argocd/servicemonitor.yaml"
    destination = "/tmp/argocd-servicemonitor.yaml"
  }

  provisioner "file" {
    source      = "${path.module}/../platform-manifests/argocd/dashboard.yaml"
    destination = "/tmp/argocd-dashboard.yaml"
  }

  provisioner "file" {
    destination = "/tmp/argocd-image-updater-config.yaml"
    content = templatefile(
      "${path.module}/../platform-manifests/argocd/argo-image-updater-config.yaml.tpl",
      {
        "domain" : "${var.prefix}.${var.domain}"
      }
    )
  }

  provisioner "file" {
    destination = "/tmp/argocd-values.yaml"
    content = templatefile(
      "${path.module}/../platform-manifests/argocd/values.yaml.tpl",
      {
        "domain" : "${var.prefix}.${var.domain}"
      }
    )
  }

  # harbor
  provisioner "file" {
    source      = "${path.module}/../platform-manifests/harbor/issuer.yaml"
    destination = "/tmp/harbor-issuer.yaml"
  }

  provisioner "file" {
    source      = "${path.module}/../platform-manifests/harbor/servicemonitor.yaml"
    destination = "/tmp/harbor-servicemonitor.yaml"
  }

  provisioner "file" {
    source      = "${path.module}/../platform-manifests/harbor/dashboard.yaml"
    destination = "/tmp/harbor-dashboard.yaml"
  }

  provisioner "file" {
    destination = "/tmp/harbor-values.yaml"
    content = templatefile(
      "${path.module}/../platform-manifests/harbor/values.yaml.tpl",
      {
        "domain" : "${var.prefix}.${var.domain}"
      }
    )
  }

  # harbor-ha (官方 2.15.0 高可用版 Helm values)
  provisioner "file" {
    destination = "/tmp/harbor-ha-values.yaml"
    content = templatefile(
      "${path.module}/../platform-manifests/harbor/values-ha.yaml.tpl",
      {
        "domain" : "${var.prefix}.${var.domain}",
        "pg_ip" : "${tencentcloud_instance.ubuntu[0].private_ip}",
        "harbor_password" : "${var.harbor_password}"
      }
    )
  }

  # nexus (内网制品库 Helm values)
  provisioner "file" {
    destination = "/tmp/nexus-values.yaml"
    content = templatefile(
      "${path.module}/../platform-manifests/nexus/values.yaml.tpl",
      {
        "domain" : "${var.prefix}.${var.domain}"
      }
    )
  }

  // cosign
  provisioner "file" {
    destination = "/tmp/cosign-key-password.yaml"
    content = templatefile(
      "${path.module}/../platform-manifests/cosign/cosign-key-password.yaml.tpl",
      {
        "cosign_password" : "${var.cosign_password}"
      }
    )
  }

  provisioner "file" {
    source      = "${path.module}/../platform-manifests/cosign/cosign-key-file-secret.yaml"
    destination = "/tmp/cosign-key-file-secret.yaml"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/init.sh",
      "bash /tmp/init.sh",
    ]
  }
}
