# Если у вас уже есть сеть, используйте data source
data "yandex_vpc_network" "default" {
  name = "default"  # или укажите имя вашей сети
}

data "yandex_vpc_subnet" "default" {
  name = "default-ru-central1-a"  # подставьте свою подсеть
}
