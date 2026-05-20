module "doks" {
  source = "../../modules/doks"

  cluster_name       = var.cluster_name
  region             = var.region
  kubernetes_version = var.kubernetes_version

  # Розмір ноди — мінімально можливий для DOKS: 1 vCPU, 2 GB RAM, 50 GB SSD
  node_size  = "s-1vcpu-2gb"
  node_count = 1

  # HA control plane і surge_upgrade вимкнені — мінімальний кластер
  ha_control_plane = false
  surge_upgrade    = false
  auto_upgrade     = false

  maintenance_start_time = "03:00"
  maintenance_day        = "sunday"

  node_labels = {
    "env"  = var.env
    "team" = "devops"
  }

  node_taints = []

  tags = [var.env, "doks", "managed-by-tofu"]
}