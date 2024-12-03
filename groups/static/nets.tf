resource "yandex_vpc_network" "static-group" {
  name = "network1"
}

resource "yandex_vpc_subnet" "static-group-subnet" {
  name           = "subnet1"
  zone           = "ru-central1-b"
  network_id     = "${yandex_vpc_network.static-group.id}"
  v4_cidr_blocks = ["192.168.10.0/24"]
}
