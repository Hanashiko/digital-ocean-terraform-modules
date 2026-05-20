# envs/dev/terraform.tfvars
# Цей файл можна комітити (без токенів!).
# Токен передавати через env: export DIGITALOCEAN_TOKEN="dop_v1_..."

cluster_name       = "temporary-test-cluster"
region             = "ams3"
kubernetes_version = "1.35.1-do.6"
env                = "dev"