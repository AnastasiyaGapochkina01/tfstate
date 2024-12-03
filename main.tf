terraform {
  required_providers {
    yandex = {
    source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"

  backend "s3" {
    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }
    bucket = "tfstate-1733220627"
    region = "ru-central1"
    key    = "tf-states/less02.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }
}
provider "yandex" {
    zone = "ru-central1-b"
    storage_access_key = "${var.access_key}"
    storage_secret_key = "${var.secret_key}"
}
