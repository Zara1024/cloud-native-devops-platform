# Nexus 3 企业级制品库 Helm 配置文件 (适用于 sonatype/nexus-repository-manager)

nexus:
  imageName: sonatype/nexus3
  imageTag: 3.68.0
  imagePullPolicy: IfNotPresent
  
  # 资源配置
  resources:
    requests:
      cpu: 500m
      memory: 2048Mi
    limits:
      cpu: 2000m
      memory: 4096Mi

  # JVM 启动参数配置 (预分配 2G 堆内存)
  env:
    - name: INSTALL4J_ADD_VM_PARAMS
      value: "-Xms2048m -Xmx2048m -XX:MaxDirectMemorySize=2048m -Djava.util.prefs.userRoot=/nexus-data/javaprefs"
    - name: NEXUS_SECURITY_RANDOMPASSWORD
      value: "false"

  # 健康检查探针
  livenessProbe:
    initialDelaySeconds: 120
    periodSeconds: 30
    failureThreshold: 6
    path: /
  readinessProbe:
    initialDelaySeconds: 60
    periodSeconds: 10
    failureThreshold: 3
    path: /

# 持久化存储配置 (使用本地高性能磁盘，支撑大量小文件读写)
persistence:
  enabled: true
  accessMode: ReadWriteOnce
  size: 100Gi
  storageClass: "local-path"

# Ingress 访问暴露配置
ingress:
  enabled: true
  ingressClassName: gitlab-nginx
  annotations:
    kubernetes.io/ingress.class: gitlab-nginx
    nginx.ingress.kubernetes.io/proxy-body-size: "1024m" # 允许上传最大 1GB 的制品包
  hostRepo: nexus.${domain}
  tls:
    enabled: true
    secretName: "nexus-secret-tls"

# Service 配置
service:
  name: nexus3
  type: ClusterIP
  port: 8081
