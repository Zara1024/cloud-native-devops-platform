# Harbor 2.15.0 企业级高可用 (HA) 配置文件
# 严格遵循官方文档规范：多副本无状态组件 + 外置数据库 + 腾讯云 CFS ReadWriteMany 共享存储

# 访问暴露配置
expose:
  type: ingress
  tls:
    enabled: true
    certSource: secret
    secret:
      secretName: "harbor-secret-tls"
      notarySecretName: "notary-secret-tls"
  ingress:
    hosts:
      core: harbor.${domain}
      notary: notary.${domain}
    className: gitlab-nginx
    annotations:
      kubernetes.io/tls-acme: "true"
      cert-manager.io/issuer: "harbor-issuer"
      nginx.ingress.kubernetes.io/proxy-body-size: "0" # 取消 Docker push 镜像分块大小限制

externalURL: https://harbor.${domain}

# ==========================================
# 1. 官方 HA 核心组件多副本扩展配置
# ==========================================
portal:
  replicas: 2
  resources:
    requests:
      cpu: 100m
      memory: 128Mi
    limits:
      cpu: 500m
      memory: 256Mi

core:
  replicas: 2
  resources:
    requests:
      cpu: 200m
      memory: 512Mi
    limits:
      cpu: 1000m
      memory: 1024Mi

jobservice:
  replicas: 2
  # 任务日志记录方式：支持 database 或 file
  jobLogger: file
  resources:
    requests:
      cpu: 200m
      memory: 512Mi
    limits:
      cpu: 1000m
      memory: 1024Mi

registry:
  replicas: 2
  resources:
    requests:
      cpu: 200m
      memory: 512Mi
    limits:
      cpu: 1500m
      memory: 2048Mi

# ==========================================
# 2. 外置数据库配置 (对接宿主机合设的高性能 PostgreSQL)
# ==========================================
database:
  type: external
  external:
    host: "${pg_ip}"
    port: "5432"
    username: "harbor"
    password: "${harbor_password}"
    coreDatabase: "registry"
    sslmode: "disable"

# ==========================================
# 3. 共享存储配置 (严格遵循官方推荐：腾讯云 CFS ReadWriteMany 存储类)
# ==========================================
persistence:
  enabled: true
  persistentVolumeClaim:
    # 核心镜像分层存储 (多副本并发读写，必须为 ReadWriteMany)
    registry:
      storageClass: "cfs-rwx"
      accessMode: ReadWriteMany
      size: 200Gi
    # 异步构建与扫描任务日志
    jobservice:
      storageClass: "cfs-rwx"
      accessMode: ReadWriteMany
      size: 20Gi

# ==========================================
# 4. 安全漏洞扫描器 Trivy 配置
# ==========================================
trivy:
  enabled: true
  replicas: 1
  persistence:
    enabled: true
    storageClass: "local-path" # 漏洞库单盘存储，使用本地高速盘即可
    size: 20Gi

# ==========================================
# 5. Prometheus 监控集成
# ==========================================
metrics:
  enabled: true
  serviceMonitor:
    enabled: true
    additionalLabels:
      release: kube-prometheus-stack
