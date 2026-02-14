data "yandex_compute_image" "debian" {
  family = var.image_family
}

resource "yandex_compute_instance" "vm" {
  name        = var.instance_name
  platform_id = "standard-v3"
  zone        = var.zone

  resources {
    cores  = var.cores
    memory = var.memory
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.debian.id
      size     = var.disk_size
    }
  }

  network_interface {
    subnet_id          = var.subnet_id
    nat                = var.nat
    security_group_ids = var.security_group_ids
  }

  metadata = {
    ssh-keys = "debian:${file(var.public_key_path)}"
    user-data = <<-EOF
      #cloud-config
      package_update: true
      packages:
        - python3
        - python3-apt
        - python3-pip
    EOF
  }

  labels = var.labels
}
