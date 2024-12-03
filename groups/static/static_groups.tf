resource "yandex_compute_instance_group" "ig-1" {
  name                = "fixed-ig-with-balancer"
  folder_id           = "b1grjv0egaues1636c99"
  service_account_id  = "${yandex_iam_service_account.ig-sa.id}"
  deletion_protection = "true"
  instance_template {
    platform_id = "standard-v3"
    resources {
      memory = 2
      cores  = 2
    }

    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = "fd82la99e48l680kkcfl"
      }
    }

    network_interface {
      network_id         = "${yandex_vpc_network.static-group.id}"
      subnet_ids         = ["${yandex_vpc_subnet.static-group-subnet.id}"]
    }

    metadata = {
      user-data = "${file("./meta.txt")}"
    }
  }

  scale_policy {
    fixed_scale {
      size = 2
    }
  }

  allocation_policy {
    zones = ["ru-central1-b"]
  }

  deploy_policy {
    max_unavailable = 1
    max_expansion   = 0
  }

  load_balancer {
    target_group_name        = "target-group"
    target_group_description = "Целевая группа Network Load Balancer"
  }
}
