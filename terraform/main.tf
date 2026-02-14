terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  zone = "ru-central1-a"
}

resource "yandex_compute_instance" "vm" {
  name = "test-vm"
  platform_id = "standard-v3"

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd8idp0b4fu2l4u5pp6m"  # Это ID образа Debian 12 (проверь актуальность)
      size     = 20
    }
  }

  network_interface {
    subnet_id = "e9b2p0b1q2s3t4u5v6w7"   # Здесь нужно указать ID твоей подсети
    nat       = true
  }

  metadata = {
    ssh-keys = "debian:${file("~/.ssh/id_rsa.pub")}"
  }
}

