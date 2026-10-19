# GitOps 应用交付仓库说明

本目录作为 Argo CD 监听的 GitOps 应用定义仓库：
- `environments/dev/values.yaml`: 开发测试环境配置；
- `environments/prod/values.yaml`: 生产环境配置（双副本、高规格）。

当流水线触发或由 Argo CD Image Updater 监听镜像变更时，将自动更新对应环境的 `image.tag`，触发集群自动同步部署。
