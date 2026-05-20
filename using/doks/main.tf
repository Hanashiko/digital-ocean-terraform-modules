module "doks" {
  source = "../../modules/doks"

  cluster_name       = var.cluster_name
  region             = var.region
  kubernetes_version = var.kubernetes_version

  node_size  = "s-1vcpu-2gb"
  node_count = 1

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