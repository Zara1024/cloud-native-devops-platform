# Cloud-Native DevOps Platform (云原生 DevOps 全链路交付平台)

> **项目定位**：基于“基础架构即代码（IaC）+ 持续集成流水线（CI）+ 供应链安全（DevSecOps）+ 声明式自动化发布（GitOps）”构建的企业级云原生 DevOps 平台实战工程。

---

## 一、核心特性与架构全景

本项目整合了工业界主流云原生开源组件，实现了从基础设施拉起到应用交付的完整闭环：

* **自动化基础设施（IaC）**：基于 Terraform 自动化创建腾讯云 VPC、子网、安全组、高规格计算节点与 Cloudflare DNS 自动化解析；
* **高可用 Kubernetes 运行时**：基于外置独立 PostgreSQL 支撑高可用 K3s 集群，并通过 containerd 规范纳管容器运行时；
* **企业级 CI/CD 流水线**：
  - **GitLab CE**：企业代码仓库，自动生成 Personal Access Token（PAT）；
  - **Jenkins (LTS JDK17)**：基于 JCasC（配置即代码）与 Kubernetes 动态 Agent 实现按需弹性构建；
  - **SonarQube**：静态代码分析与质量门禁（Quality Gate）强校验；
  - **Kaniko**：Kubernetes Pod 内无特权 Docker 镜像安全构建；
  - **Grype / Trivy**：容器镜像静态 CVE 漏洞扫描与阻断；
  - **Sigstore Cosign**：容器镜像非对称数字签名，杜绝供应链镜像篡改；
* **GitOps 持续交付**：
  - **Harbor**：企业级私有 OCI 镜像仓库，对接 Cosign 信任链；
  - **Argo CD**：基于 GitOps 理念实现开发（Dev）与生产（Prod）多环境持续自动部署；
  - **Argo CD Image Updater**：监听 Harbor 镜像变更并自动写回 Git 仓库触发平滑发布；
* **可观测性栈**：集成 Prometheus + Grafana + Loki，内置各组件专属监控大屏。

---

## 二、代码工程目录说明

```text
cloud-native-devops-platform/
├── .gitignore                          # 生产级敏感文件隔离规则 (排除 *.tfvars, *.key, *.tfstate 等)
├── README.md                           # 平台全景说明与指引
├── docs/                               # 详细架构与运维手册
│   ├── architecture.md                 # 生产级高可用架构设计与规划规范
│   └── troubleshooting-guide.md        # 15+ 项实战排坑、底层缺陷根因排查全记录
│
├── terraform-infra/                    # 基础设施代码 (IaC 自动化底座)
│   ├── modules/
│   │   └── pg-datastore/               # 独立 PostgreSQL 数据库实例模块
│   ├── cloudflare.tf                   # Cloudflare DNS 子域名解析规则
│   ├── cvm.tf                          # K3s 主节点 CVM 计算实例与规格定义
│   ├── k3s.tf                          # 节点 Provision 与 Manifests 远程渲染编排
│   ├── init.sh.tpl                     # 集群全栈初始化脚本 (支持自动重试与补丁)
│   ├── vpc.tf                          # VPC 与子网规则
│   ├── sg.tf                           # 安全组与端口管控
│   ├── variables.tf                    # 参数变量定义 (已脱敏)
│   ├── version.tf                      # Provider 版本锁定
│   ├── output.tf                       # 自动化输出信息 (IP、访问凭据)
│   └── terraform.tfvars.example        # 凭证配置模板 (严禁提交实际密钥)
│
├── platform-manifests/                 # 平台管控服务声明清单 (Helm / YAML)
│   ├── gitlab/                         # GitLab Helm 配置、Issuer、Secret 模板
│   ├── harbor/                         # Harbor 企业镜像仓库配置、ServiceMonitor、Dashboard
│   ├── jenkins/                        # Jenkins Values、JCasC 声明、Kubernetes 凭据模板
│   ├── sonarqube/                      # SonarQube Values、Prometheus Exporter、Dashboard
│   ├── argocd/                         # Argo CD Values、ApplicationSet、Image Updater 配置
│   ├── cosign/                         # Cosign 密钥挂载声明与镜像构建 Dockerfile
│   ├── prometheus/                     # kube-prometheus-stack 监控栈 Values
│   └── sbom/                           # 软件物料清单 SBOM 生成与扫描示例
│
└── gitops-applications/                # 业务交付流水线与环境管理 (Argo CD 纳管)
    ├── helm-charts/                    # 业务通用微服务 Helm 模板
    └── environments/                   # 多环境声明式发布
        ├── dev/values.yaml             # 开发测试环境配置
        ├── staging/values.yaml         # 预发环境配置
        └── prod/values.yaml            # 生产环境配置
```

---

## 三、快速开始

### 1. 准备工作
- 安装 [Terraform](https://developer.hashicorp.com/terraform/downloads) (`v1.5+`)；
- 准备腾讯云账号（具备 CVM、VPC 操作权限）与 Cloudflare 托管域名（及 API Token）。

### 2. 配置变量
进入 `terraform-infra` 目录，由模板生成本地变量文件：
```bash
cd terraform-infra
cp terraform.tfvars.example terraform.tfvars
```
编辑 `terraform.tfvars` 填入您的凭证与域名信息：
```hcl
secret_id          = "AKID..."
secret_key         = "..."
cloudflare_api_key = "cfut_..."
domain             = "yourdomain.com"
prefix             = "demo"
instance_charge_type = "SPOTPAID" # 使用竞价实例以节约 80%+ 实验成本
```

### 3. 一键初始化与部署
```bash
terraform init
terraform plan
terraform apply -auto-approve
```
> **注意**：整个拉起与配置过程大约持续 10~15 分钟。执行完毕后，控制台将输出各管理系统的访问 URL 与初始登录凭据。

### 4. 资源彻底清理（销毁）
实验或演示完成后，务必一键销毁云端资源，避免持续产生费用：
```bash
terraform destroy -auto-approve
```

---

## 四、安全与开源声明

1. **凭证脱敏**：本仓库中所有的密码、Token、AK/SK、私钥均已替换为标准占位符模板；本地调试生成的 `terraform.tfvars` 已被 `.gitignore` 严格忽略，杜绝泄漏；
2. **排坑指南**：在搭建过程中遇到任何 Pod 状态、镜像拉取、证书报错，请详阅 [docs/troubleshooting-guide.md](docs/troubleshooting-guide.md)。
