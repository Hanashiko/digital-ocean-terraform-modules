output "cluster_id" {
  description = "UUID кластера в DigitalOcean."
  value       = digitalocean_kubernetes_cluster.this.id
}

output "cluster_name" {
  description = "Назва кластера."
  value       = digitalocean_kubernetes_cluster.this.name
}

output "cluster_endpoint" {
  description = "HTTPS endpoint Kubernetes API server."
  value       = digitalocean_kubernetes_cluster.this.endpoint
}

output "cluster_status" {
  description = "Поточний статус кластера (running, provisioning, ...)."
  value       = digitalocean_kubernetes_cluster.this.status
}

output "kubernetes_version" {
  description = "Фактична версія Kubernetes (з patch, наприклад 1.32.2-do.0)."
  value       = digitalocean_kubernetes_cluster.this.version
}

output "node_pool_id" {
  description = "UUID default node pool."
  value       = digitalocean_kubernetes_cluster.this.node_pool[0].id
}

# --------------------------------------------------------------------------
# kubeconfig
# --------------------------------------------------------------------------
# ВАЖЛИВО: kubeconfig містить Bearer token і є чутливими даними.
# sensitive = true — Terraform не виводитиме значення в stdout під час apply/plan.
# Щоб отримати: `tofu output -raw kubeconfig > ~/.kube/config`
output "kubeconfig" {
  description = <<-EOT
    Raw kubeconfig у форматі YAML.
    Зберігається як sensitive, тому не відображається в stdout.
    Отримати: tofu output -raw kubeconfig > ~/.kube/config
  EOT
  value       = digitalocean_kubernetes_cluster.this.kube_config[0].raw_config
  sensitive   = true
}

# Окремі компоненти kubeconfig — зручно для передачі в інші модулі
output "cluster_ca_certificate" {
  description = "Base64-encoded CA certificate кластера."
  value       = digitalocean_kubernetes_cluster.this.kube_config[0].cluster_ca_certificate
  sensitive   = true
}

output "kube_config_token" {
  description = "Bearer token для автентифікації в Kubernetes API."
  value       = digitalocean_kubernetes_cluster.this.kube_config[0].token
  sensitive   = true
}

output "kube_config_host" {
  description = "URL Kubernetes API server (з kube_config блоку)."
  value       = digitalocean_kubernetes_cluster.this.kube_config[0].host
}

output "kube_config_expires_at" {
  description = "Дата закінчення терміну дії токена (ISO 8601)."
  value       = digitalocean_kubernetes_cluster.this.kube_config[0].expires_at
}