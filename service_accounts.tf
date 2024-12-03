resource "yandex_iam_service_account" "sa_tfstate" {
  name      = "sa-tfstate"
  folder_id = "b1grjv0egaues1636c99"
}

resource "yandex_iam_service_account_static_access_key" "sa_tfstate_static_key" {
  service_account_id = yandex_iam_service_account.sa_tfstate.id
  description        = "static access key for object storage"
}

resource "yandex_resourcemanager_folder_iam_member" "tfstate_admin" {
  folder_id   = "b1grjv0egaues1636c99"
  role        = "storage.admin"
  member    = "serviceAccount:${yandex_iam_service_account.sa_tfstate.id}"
}

output "access_key" {
  value = yandex_iam_service_account_static_access_key.sa_tfstate_static_key.access_key
  sensitive = true
}

output "secret_key" {
  value = yandex_iam_service_account_static_access_key.sa_tfstate_static_key.secret_key
  sensitive = true
}

