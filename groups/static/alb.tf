resource "yandex_iam_service_account" "ig-sa" {
  name        = "ig-sa"
  description = "Сервисный аккаунт для управления группой ВМ."
}

resource "yandex_resourcemanager_folder_iam_member" "editor" {
  folder_id = "<идентификатор_каталога>"
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.ig-sa.id}"
}

resource "yandex_compute_instance_group" "ig-1" {
  name                = "fixed-ig-with-balancer"
  folder_id           = "<идентификатор_каталога>"
  service_account_id  = "${yandex_iam_service_account.ig-sa.id}"
  deletion_protection = "<защита_от_удаления>"
  instance_template {
    platform_id = "standard-v3"
    resources {
      memory = <объем_RAM_ГБ>
      cores  = <количество_ядер_vCPU>
    }

    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = "<идентификатор_образа>"
      }
    }

    network_interface {
      network_id         = "${yandex_vpc_network.network-1.id}"
      subnet_ids         = ["${yandex_vpc_subnet.subnet-1.id}"]
      security_group_ids = ["<список_идентификаторов_групп_безопасности>"]
    }

    metadata = {
      ssh-keys = "<имя_пользователя>:<содержимое_SSH-ключа>"
    }
  }

  scale_policy {
    fixed_scale {
      size = <количество_ВМ_в_группе>
    }
  }

  allocation_policy {
    zones = ["ru-central1-a"]
  }

  deploy_policy {
    max_unavailable = 1
    max_expansion   = 0
  }

  application_load_balancer {
    target_group_name        = "target-group"
    target_group_description = "Целевая группа Network Load Balancer"
  }
}

resource "yandex_vpc_network" "network-1" {
  name = "network1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "ru-central1-a"
  network_id     = "${yandex_vpc_network.network-1.id}"
  v4_cidr_blocks = ["192.168.10.0/24"]
}
