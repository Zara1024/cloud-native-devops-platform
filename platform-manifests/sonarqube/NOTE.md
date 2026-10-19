jenkins plugin: https://docs.sonarqube.org/latest/analyzing-source-code/scanners/jenkins-extension-sonarqube/

install first, need 3 min start

helm repo add sonarqube https://SonarSource.github.io/helm-chart-sonarqube && helm repo update
helm upgrade --install -n sonarqube sonarqube sonarqube/sonarqube --create-namespace --version 10.1.0+628


鍒涘缓 ingress锛?
璁剧疆 Hosts锛?
鍒涘缓椤圭洰锛?
curl --location 'http://localhost:9000/api/projects/create' \
--header 'Content-Type: application/x-www-form-urlencoded' \
--header 'Authorization: Basic YWRtaW46YWRtaW4xMjM=' \
--data-urlencode 'name=camp-go-example' \
--data-urlencode 'project=camp-go-example'

鍒涘缓 token锛?
curl --location 'http://localhost:9000/api/user_tokens/generate' \
--header 'Content-Type: application/x-www-form-urlencoded' \
--header 'Authorization: Basic YWRtaW46YWRtaW4xMjM=' \
--data-urlencode 'name=camp-go-example'

{
    "login": "admin",
    "name": "camp-go-example",
    "token": "squ_YOUR_SONAR_TOKEN",
    "createdAt": "2023-06-22T02:36:42+0000",
    "type": "USER_TOKEN"
}

# init.sh

鍒涘缓 Jenkins 浣跨敤鐨?credentials锛?
```
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
  text: squ_YOUR_SONAR_TOKEN
```

鍒涘缓 webhooks锛?
curl --location 'http://localhost:9000/api/webhooks/create' \
--header 'Content-Type: application/x-www-form-urlencoded' \
--header 'Authorization: Basic YWRtaW46YWRtaW4xMjM=' \
--data-urlencode 'name=camp-go-example' \
--data-urlencode 'url=http://jenkins.wei2.gkdevopscamp.com/sonarqube-webhook/' \
--data-urlencode 'project=camp-go-example'
