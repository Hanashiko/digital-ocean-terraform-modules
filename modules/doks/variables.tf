variable "cluster_name" {
  description = "Назва DOKS кластера."
  type        = string
}

variable "region" {
  description = "DigitalOcean регіон (slug). Приклад: fra1, ams3, nyc3, sgp1."
  type        = string
  default     = "fra1"
}

variable "kubernetes_version" {
  description = <<-EOT
    Версія Kubernetes у форматі, який повертає DO API (наприклад, "1.32.2-do.0").
    Актуальний список: `doctl kubernetes options versions`.
    Якщо передати prefix без patch (наприклад "1.32"), провайдер сам обере останній patch.
  EOT
  type        = string
}

variable "auto_upgrade" {
  description = "Автоматично оновлювати patch-версію Kubernetes під час maintenance window."
  type        = bool
  default     = false
}

variable "surge_upgrade" {
  description = <<-EOT
    Під час оновлення піднімати додаткову ноду перш ніж дрейнувати стару (zero-downtime upgrade).
    Рекомендовано true для prod, але потребує capacity для +1 ноди.
  EOT
  type        = bool
  default     = false
}

variable "ha_control_plane" {
  description = "High-Availability control plane (3 etcd + 3 API servers). Платна опція."
  type        = bool
  default     = false
}

variable "maintenance_start_time" {
  description = "Час початку maintenance window (UTC, формат HH:00). Приклад: '03:00'."
  type        = string
  default     = "03:00"
}

variable "maintenance_day" {
  description = "День тижня для maintenance window. Значення: monday..sunday або 'any'."
  type        = string
  default     = "sunday"

  validation {
    condition = contains(
      ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday", "any"],
      var.maintenance_day
    )
    error_message = "maintenance_day має бути одним із: monday, tuesday, wednesday, thursday, friday, saturday, sunday, any."
  }
}

variable "node_size" {
  description = <<-EOT
    Slug розміру ноди. Список підтримуваних для DOKS:
      s-1vcpu-2gb   — 1 vCPU, 2 GB RAM, 50 GB SSD  (мінімум)
      s-2vcpu-4gb   — 2 vCPU, 4 GB RAM, 80 GB SSD
      s-4vcpu-8gb   — 4 vCPU, 8 GB RAM, 160 GB SSD
    Повний список: `doctl kubernetes options sizes`.
  EOT
  type        = string
  default     = "s-1vcpu-2gb"
}

variable "node_count" {
  description = "Кількість нод у default node pool."
  type        = number
  default     = 1

  validation {
    condition     = var.node_count >= 1
    error_message = "node_count має бути >= 1."
  }
}

variable "node_labels" {
  description = "Map Kubernetes node labels, які застосовуються до всіх нод пулу."
  type        = map(string)
  default     = {}
}

variable "node_taints" {
  description = <<-EOT
    Список Kubernetes taints для нод пулу.
    Кожен об'єкт: { key, value, effect }
    effect може бути: NoSchedule | PreferNoSchedule | NoExecute
  EOT
  type = list(object({
    key    = string
    value  = string
    effect = string
  }))
  default = []
}

variable "tags" {
  description = "DigitalOcean теги, що застосовуються до кластера і нод."
  type        = list(string)
  default     = []
}