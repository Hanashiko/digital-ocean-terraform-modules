terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

# ------------------------------------------------------------------------------
# DOKS Cluster
# ------------------------------------------------------------------------------
resource "digitalocean_kubernetes_cluster" "this" {
  name    = var.cluster_name
  region  = var.region
  version = var.kubernetes_version

  # Якщо auto_upgrade = true, DO оновлюватиме patch-версію автоматично.
  # Для prod краще false, щоб контролювати вручну.
  auto_upgrade  = var.auto_upgrade
  surge_upgrade = var.surge_upgrade

  # HA control plane (3 etcd + 3 API servers) — платно, для мінімального кластера вимкнено
  ha = var.ha_control_plane

  # Maintenance window для автооновлень (формат: день тижня + час UTC)
  maintenance_policy {
    start_time = var.maintenance_start_time
    day        = var.maintenance_day
  }

  # Default node pool — обов'язковий для DOKS
  node_pool {
    name       = "${var.cluster_name}-default-pool"
    size       = var.node_size
    node_count = var.node_count

    # Labels прокидаються на всі ноди як Kubernetes node labels
    labels = var.node_labels

    # Taints — якщо потрібно ізолювати default pool
    dynamic "taint" {
      for_each = var.node_taints
      content {
        key    = taint.value.key
        value  = taint.value.value
        effect = taint.value.effect
      }
    }
  }

  tags = var.tags
}