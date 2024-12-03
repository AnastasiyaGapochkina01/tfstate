resource "yandex_storage_bucket" "tfstate" {
  access_key = yandex_iam_service_account_static_access_key.sa_tfstate_static_key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa_tfstate_static_key.secret_key
  bucket     = "tfstate-1733220627"

  versioning {
    enabled = true
  }
}
