output "public_ip" {
  description = "The public ip of instance."
  value       = tencentcloud_instance.ubuntu[0].public_ip
}

output "pg_private_ip" {
  description = "宿主机合设 PostgreSQL 内网 IP"
  value       = tencentcloud_instance.ubuntu[0].private_ip
}

output "ssh_password" {
  description = "The SSH password of instance."
  value       = var.password
}
