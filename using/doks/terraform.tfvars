# envs/dev/terraform.tfvars
# Safe to commit (no tokens!).
# Pass the token via env: export DIGITALOCEAN_TOKEN="dop_v1_..."

cluster_name       = "temporary-test-cluster"
region             = "ams3"
kubernetes_version = "1.35.1-do.6"
env                = "dev"