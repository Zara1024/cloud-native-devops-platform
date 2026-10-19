# ==========================================
# 腾讯云 CFS 弹性文件存储编排 (为 Harbor HA 提供 ReadWriteMany 底座)
# ==========================================

# 1. 创建 CFS 专用权限组
resource "tencentcloud_cfs_access_group" "cfs_ag" {
  name        = "devops-cfs-access-group"
  description = "DevOps 平台集群 CFS 共享存储权限组"
}

# 2. 为权限组添加 VPC 子网访问规则 (允许读写，不降权 root)
resource "tencentcloud_cfs_access_rule" "cfs_rule" {
  access_group_id = tencentcloud_cfs_access_group.cfs_ag.id
  auth_client_ip  = var.vpc_cidr
  priority        = 1
  rw_permission   = "RW"
  user_permission = "no_root_squash"
}

# 3. 创建 CFS 文件系统实例
resource "tencentcloud_cfs_file_system" "harbor_cfs" {
  name            = "devops-harbor-cfs"
  zone            = var.availability_zone
  vpc_id          = tencentcloud_vpc.tf_vpc.id
  subnet_id       = tencentcloud_subnet.tf_service_subnet.id
  access_group_id = tencentcloud_cfs_access_group.cfs_ag.id
  protocol        = "NFS"
  storage_type    = "SD" # 标准型存储

  tags = var.tags
}

# 4. 输出 CFS 挂载点内网 IP
output "cfs_mount_ip" {
  description = "腾讯云 CFS 弹性文件存储挂载点内网 IP"
  value       = tencentcloud_cfs_file_system.harbor_cfs.mount_ip
}
