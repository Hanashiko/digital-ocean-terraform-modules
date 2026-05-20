variable "cluster_name" {
  description = "DOKS cluster name."
  type        = string
}

variable "region" {
  description = "DigitalOcean region (slug). Examples: fra1, ams3, nyc3, sgp1."
  type        = string
  default     = "fra1"
}

variable "kubernetes_version" {
  description = <<-EOT
    Kubernetes version in the format returned by the DO API (e.g., "1.32.2-do.0").
    Available versions: `doctl kubernetes options versions`.
    If you pass a prefix without patch (e.g. "1.32"), the provider will select the latest patch.
  EOT
  type        = string
}

variable "auto_upgrade" {
  description = "Automatically update the Kubernetes patch version during the maintenance window."
  type        = bool
  default     = false
}

variable "surge_upgrade" {
  description = <<-EOT
    Spin up an additional node before draining the old one during updates (zero-downtime upgrade).
    Recommended true for prod, but requires capacity for +1 node.
  EOT
  type        = bool
  default     = false
}

variable "ha_control_plane" {
  description = "High-Availability control plane (3 etcd + 3 API servers). Paid option."
  type        = bool
  default     = false
}

variable "maintenance_start_time" {
  description = "Maintenance window start time (UTC, format HH:00). Example: '03:00'."
  type        = string
  default     = "03:00"
}

variable "maintenance_day" {
  description = "Day of week for the maintenance window. Values: monday..sunday or 'any'."
  type        = string
  default     = "sunday"

  validation {
    condition = contains(
      ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday", "any"],
      var.maintenance_day
    )
    error_message = "maintenance_day must be one of: monday, tuesday, wednesday, thursday, friday, saturday, sunday, any."
  }
}

variable "node_size" {
  description = <<-EOT
    Node size slug. Supported sizes for DOKS:
      s-1vcpu-2gb   — 1 vCPU, 2 GB RAM, 50 GB SSD  (minimum)
      s-2vcpu-4gb   — 2 vCPU, 4 GB RAM, 80 GB SSD
      s-4vcpu-8gb   — 4 vCPU, 8 GB RAM, 160 GB SSD
    Full list: `doctl kubernetes options sizes`.
  EOT
  type        = string
  default     = "s-1vcpu-2gb"
}

variable "node_count" {
  description = "Number of nodes in the default node pool."
  type        = number
  default     = 1

  validation {
    condition     = var.node_count >= 1
    error_message = "node_count must be >= 1."
  }
}

variable "node_labels" {
  description = "Map of Kubernetes node labels applied to all nodes in the pool."
  type        = map(string)
  default     = {}
}

variable "node_taints" {
  description = <<-EOT
    List of Kubernetes taints for pool nodes.
    Each object: { key, value, effect }
    effect can be: NoSchedule | PreferNoSchedule | NoExecute
  EOT
  type = list(object({
    key    = string
    value  = string
    effect = string
  }))
  default = []
}

variable "tags" {
  description = "DigitalOcean tags applied to the cluster and nodes."
  type        = list(string)
  default     = []
}