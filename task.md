# 任务清单：企业级生产架构改造（Nexus + Harbor HA + 单机合设 PG + 腾讯云 CFS RWX SC）

- [x] 1. 编写实施计划文档 `implementation_plan.md` <!-- id: 1 -->
- [x] 2. 创建 Nexus 内网制品库 Helm 模板清单 `platform-manifests/nexus/values.yaml.tpl` <!-- id: 2 -->
- [x] 3. 创建 Harbor 官方 2.15.0 高可用 Helm 模板清单 `platform-manifests/harbor/values-ha.yaml.tpl` <!-- id: 3 -->
- [x] 4. 编写腾讯云 CFS 弹性文件存储与 RWX StorageClass 编排 `terraform-infra/cfs.tf` <!-- id: 4 -->
- [x] 5. 精简重构 CVM 编排与移除独立 PG 虚机 `terraform-infra/k3s.tf` <!-- id: 5 -->
- [x] 6. 升级主机自动化部署脚本 `terraform-infra/init.sh.tpl` 与输入变量 `variables.tf` / `output.tf` <!-- id: 6 -->
- [x] 7. 编写企业生产级架构演进与使用指南 `docs/enterprise-architecture.md` <!-- id: 7 -->
- [x] 8. 验证所有配置文件与 Terraform 模板完整性 <!-- id: 8 -->
