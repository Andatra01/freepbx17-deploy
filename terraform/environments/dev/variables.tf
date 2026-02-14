variable "public_key_path" {
  description = "Path to SSH public key"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

# Пароль администратора FreePBX будем передавать через переменную окружения или GitHub Secrets
variable "admin_password" {
  description = "Admin password for FreePBX"
  type        = string
  sensitive   = true
}
