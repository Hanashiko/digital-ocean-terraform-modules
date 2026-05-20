variable "cluster_name" {
  description = "Назва кластера."
  type        = string
  default     = "zomro-dev"
}

variable "region" {
  description = "DigitalOcean регіон."
  type        = string
  default     = "fra1"
}

variable "kubernetes_version" {
  description = <<-EOT
    Версія Kubernetes. Актуальний список:
      doctl kubernetes options versions
    Приклад: "1.32.2-do.0"
  EOT
  type        = string
  # Не ставимо default — версія має бути явно задана в tfvars,
  # щоб уникнути непередбаченого дрейфу при плані.
}

variable "env" {
  description = "Ім'я оточення (dev, staging, prod). Використовується для тегів і лейблів."
  type        = string
  default     = "dev"
}

# Опціонально: якщо хочеш передавати токен через змінну замість env
# variable "do_token" {
#   description = "DigitalOcean API token."
#   type        = string
#   sensitive   = true
# }