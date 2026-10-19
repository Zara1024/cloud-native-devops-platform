# 生产级云原生 DevOps 平台架构设计文档

## 1. 架构目标与关键指征 (SLO / SLA)

| 指标维度 | 目标设计 |
| :--- | :--- |
| **平台可用性 (SLA)** | ≥ 99.95% (跨多可用区部署) |
| **数据恢复目标 (RPO)** | ≤ 1 小时 (云数据库开启 PITR 实时归档，Velero 每日快照) |
| **故障恢复时间 (RTO)** | ≤ 30 分钟 (基于 IaC 与 GitOps 一键拉起或恢复) |
| **安全准入门禁拦截率** | 100% (未签名或含高危漏洞镜像一票否决) |

## 2. 核心网络流转拓扑

1. **外部流量接入**：
   - 用户访问 -> Cloudflare WAF -> 云平台公网负载均衡 (CLB / ALB) -> Ingress Controller (nginx-ingress / Envoy) -> 内部微服务；
   - 内部 Ingress 强制 HTTPS，TLS 证书由 `cert-manager` 自动从 Let's Encrypt 签发并轮换。
2. **管理控制流 (GitOps)**：
   - 开发者 Push 代码至 GitLab / GitHub；
   - Webhook 触发 Jenkins Agent 执行容器化构建（Kaniko）；
   - 测试通过后，执行 Grype 扫描 + Cosign 私钥签名，推送至 Harbor；
   - Argo CD 监听 Helm Chart / ApplicationSet，自动将变更同步至对应 Kubernetes 业务集群。

## 3. 密钥生命周期管理 (Zero Secrets in Git)

- 所有真实数据库密码、Token、API Key 统一录入云厂商 KMS 或 HashiCorp Vault；
- Kubernetes 命名空间内配置 `ExternalSecret` CRD；
- `external-secrets-operator` 负责单向同步，将密文解密注入为原生 Kubernetes `Secret`；
- Git 仓库中仅保留 `ExternalSecret` 的声明模板，杜绝一切泄密风险。
