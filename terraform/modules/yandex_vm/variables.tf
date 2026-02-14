variable "instance_name" {
  description = "Имя виртуальной машины"
  type        = string
}

variable "zone" {
  description = "Зона доступности"
  type        = string
  default     = "ru-central1-a"
}

variable "cores" {
  description = "Количество ядер CPU"
  type        = number
  default     = 2
}

variable "memory" {
  description = "Объем RAM в ГБ"
  type        = number
  default     = 4
}

variable "disk_size" {
  description = "Размер загрузочного диска в ГБ"
  type        = number
  default     = 20
}

variable "image_family" {
  description = "Семейство образа ОС"
  type        = string
  default     = "debian-12"
}

variable "subnet_id" {
  description = "ID подсети"
  type        = string
}

variable "nat" {
  description = "Назначать публичный IP"
  type        = bool
  default     = true
}

variable "security_group_ids" {
  description = "Список ID групп безопасности"
  type        = list(string)
  default     = []
}

variable "public_key_path" {
  description = "Путь к открытому ключу SSH"
  type        = string
}

variable "labels" {
  description = "Метки для ресурса"
  type        = map(string)
  default     = {}
}
