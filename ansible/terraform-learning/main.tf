# Это провайдер для работы с локальными файлами. Ему не нужны никакие ключи.
terraform {
  required_providers {
    local = {
      source = "hashicorp/local"
      version = "1.14.0"
    }
  }
}

resource "local_file" "my_first_file" {
  content  = "Я только что создал файл с помощью Terraform!"
  filename = "${path.module}/hello.txt"
}
