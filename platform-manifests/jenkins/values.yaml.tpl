agent:
  resources:
    requests:
      cpu: "512m"
      memory: "512Mi"
    limits:
      cpu: "2000m"
      memory: "2048Mi"
controller:
  image: "jenkins/jenkins"
  tag: "lts-jdk17"
  containerEnv:
    - name: HARBOR_URL
      value: "harbor.${domain}"
  ingress:
    enabled: true
    hostName: jenkins.${domain}
    ingressClassName: gitlab-nginx
  adminPassword: "${jenkins_password}"
  prometheus:
    enabled: true
    serviceMonitorNamespace: "monitoring"
  installPlugins:
    - kubernetes
    - workflow-aggregator
    - git
    - configuration-as-code
  additionalPlugins:
    - prometheus
    - kubernetes-credentials-provider
    - job-dsl
    - github
    - github-branch-source
    - gitlab-branch-source
    - gitlab-kubernetes-credentials
    - pipeline-stage-view
    - sonar
#    - gitlab-plugin:1.7.14
#    - gitlab-api:5.2.0-86.v1ed41a_9cf486
  JCasC:
    defaultConfig: true
    configScripts:
      welcome-message: |
       jenkins:
         systemMessage: Welcome to GeekBang Cloud Native Camp!
         globalNodeProperties:
           - envVars:
               env:
                 - key: "GIT_SSL_NO_VERIFY"
                   value: "true"
      jenkins-casc-configs: |
        unclassified:
          sonarglobalconfiguration:
            buildWrapperEnabled: true
            installations:
              - name: "camp-go-example"
                credentialsId: "sonarqube-token"
                serverUrl: "http://sonar.${domain}"
          gitLabServers:
            servers:
              - credentialsId: "gitlab-token"
                manageWebHooks: true
                manageSystemHooks: true
                name: "gitlab-server"
                serverUrl: "http://gitlab.${domain}"
                hooksRootUrl: ""
      example-job: |
        jobs:
          - script: >
              multibranchPipelineJob('build-go-example') {
                branchSources {
                  branchSource {
                    source {
                      gitlab {
                        serverName('gitlab-server')
                        projectOwner('root')
                        projectPath('root/camp-go-example')
                        credentialsId('gitlab-pull-secret')
                        id('build-go-example')
                        //projectId(long value)
                        traits {
                          gitLabBranchDiscovery {
                            strategyId(3)  // discover all branches
                          }
                          originMergeRequestDiscoveryTrait {
                            strategyId(1)  // discover MRs and merge them with target branch
                          }
                          gitLabTagDiscovery() // discover tags
                        }
                      }
                    }
                  }
                }
                triggers {
                  periodicFolderTrigger {
                    interval("1")
                  }
                }
                orphanedItemStrategy {
                  discardOldItems()
                }
              }