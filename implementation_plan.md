# 实施计划：DevOps 平台企业级生产架构改造

## 1. 方案目标与背景
本项目旨在将当前轻量个人 Demo 级别的架构，吸纳中国移动“磐舟”大型生产环境的核心设计规范，升级为兼具高可用与低成本的**企业生产级云原生交付底座**：
1. **降本增效**：砍掉原项目中独立用于跑单个 PostgreSQL 容器的 2C2G 虚拟机，改为在单台主力 CVM 宿主机上通过 Docker 合设运行 PostgreSQL 14 并持久化，同时为 K3s、Harbor HA 及平台提供底层数据库支持，服务器成本降低 50%；
2. **内网依赖加速与隔离**：新增企业级 **Nexus 3 制品库**，代理并本地缓存 Maven Central、npm 等外部源，支持全内网离线构建；
3. **官方规范 Harbor 高可用（HA）**：严格遵循 Harbor 官方 2.15.0 Helm 推荐标准，通过 Terraform 自动开通**腾讯云 CFS 弹性文件存储**，在集群中动态注册支持 `ReadWriteMany (RWX)` 的 StorageClass，实现 Core/Portal/Jobservice/Registry 多副本无状态化、外置 PG 解耦；
4. **IaC 一键端到端生成**：所有配置均采用 Terraform 声明式编排，用户仅需执行 `terraform apply` 即可全自动完成从云资源到 K8s 应用的端到端拉起。

---

## 2. 改造范围与文件变更

| 文件路径 | 变更类型 | 详细说明 |
| :--- | :--- | :--- |
| `platform-manifests/nexus/values.yaml.tpl` | 新增 | Nexus 3 官方 Helm Chart 配置模板，包含存储卷绑定与 Ingress 路由 |
| `platform-manifests/harbor/values-ha.yaml.tpl` | 新增 | Harbor 官方 2.15.0 高可用配置模板（多副本、外置 PG、腾讯云 CFS RWX 存储卷） |
| `terraform-infra/cfs.tf` | 新增 | 腾讯云 CFS 文件系统编排与 K8s NFS-Client Provisioner / RWX StorageClass 动态注册 |
| `terraform-infra/k3s.tf` | 修改 | 移除独立的 `module.pg` 模块，新增 Nexus 与 Harbor HA 模板分发配置 |
| `terraform-infra/init.sh.tpl` | 修改 | 新增宿主机合设 PG 自动预建双库、新增 `setup_nexus` 与 `setup_harbor_ha` 部署函数 |
| `terraform-infra/variables.tf` | 修改 | 新增 CFS 存储类型、Nexus 存储规格等配置变量 |
| `terraform-infra/terraform.tfvars.example` | 修改 | 更新参数示例 |
| `docs/enterprise-architecture.md` | 新增 | 企业生产级架构白皮书与详细使用指南 |

---

## 3. 详细实施步骤

### 步骤一：创建 Nexus 制品库 Helm 配置清单
- 目录：`platform-manifests/nexus/`
- 配置 JVM 内存参数（`-Xms2g -Xmx2g`）；
- 挂载持久卷（100Gi，支持本地 `local-path` 或云盘）；
- 暴露 Ingress 域名 `nexus.${domain}`。

### 步骤二：创建 Harbor 2.15.0 高可用 Helm 配置清单
- 目录：`platform-manifests/harbor/values-ha.yaml.tpl`
- 开启多副本：`portal.replicas: 2`、`core.replicas: 2`、`jobservice.replicas: 2`、`registry.replicas: 2`；
- 外置数据库连接宿主机 PG 5432；
- 存储采用 `ReadWriteMany` PVC，绑定腾讯云 CFS 存储类。

### 步骤三：编写腾讯云 CFS 基础设施编排（`cfs.tf`）
- 声明 `tencentcloud_cfs_file_system` 资源；
- 配合子网与 VPC，获取 NFS 挂载点 IP；
- 在集群中自动安装 NFS-Subdir-External-Provisioner，创建名为 `cfs-rwx` 的 StorageClass。

### 步骤四：重构 `k3s.tf` 与 `init.sh.tpl`
- 砍掉外置第二台 CVM；
- 在主力 CVM 上首先拉起 Docker PostgreSQL 容器，自动预建 `kubernetes` 和 `registry` 两个数据库；
- 顺序部署 K3s ➔ CFS RWX SC ➔ Nexus ➔ Harbor HA ➔ GitLab / Jenkins / ArgoCD。

### 步骤五：编写架构文档与验证
- 验证所有 HCL 模板变量替换的完整性；
- 编写完整的文档《企业生产级 DevOps 架构演进指南》。
