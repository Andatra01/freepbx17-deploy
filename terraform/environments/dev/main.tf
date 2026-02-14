terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  backend "local" {  # для dev пока local, позже можно переключить на S3 (Yandex Object Storage)
    path = "terraform.tfstate"
  }
}

provider "yandex" {
  zone = "ru-central1-a"
  # Токен и папка берутся из переменных окружения YC_TOKEN, YC_CLOUD_ID, YC_FOLDER_ID
}

# Получаем существующую сеть/подсеть (или создаём)
data "yandex_vpc_network" "default" {
  name = "default"  # измените на имя вашей сети
}

data "yandex_vpc_subnet" "default" {
  name = "default-ru-central1-a"  # измените на имя вашей подсети
}

# Группа безопасности (создаётся в этом же окружении или можно вынести в global)
resource "yandex_vpc_security_group" "freepbx" {
  name        = "freepbx-dev"
  description = "Rules for FreePBX"
  network_id  = data.yandex_vpc_network.default.id

  ingress {
    protocol       = "TCP"
    port           = 22
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    protocol       = "TCP"
    port           = 80
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    protocol       = "TCP"
    port           = 443
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

module "freepbx_vm" {
  source = "../../modules/yandex_vm"

  instance_name   = "freepbx-dev"
  zone            = "ru-central1-a"
  cores           = 2
  memory          = 4
  disk_size       = 30
  subnet_id       = data.yandex_vpc_subnet.default.id
  nat             = true
  security_group_ids = [yandex_vpc_security_group.freepbx.id]
  public_key_path = var.public_key_path
  labels = {
    environment = "dev"
    project     = "freepbx"
  }
}

output "freepbx_external_ip" {
  value = module.freepbx_vm.external_ip
}
