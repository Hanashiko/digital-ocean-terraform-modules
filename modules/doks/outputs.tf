output "cluster_id" {
  description = "Cluster UUID in DigitalOcean."
  value       = digitalocean_kubernetes_cluster.this.id
}

output "cluster_name" {
  description = "Cluster name."
  value       = digitalocean_kubernetes_cluster.this.name
}

output "cluster_endpoint" {
  description = "HTTPS endpoint of the Kubernetes API server."
  value       = digitalocean_kubernetes_cluster.this.endpoint
}

output "cluster_status" {
  description = "Current cluster status (running, provisioning, ...)."
  value       = digitalocean_kubernetes_cluster.this.status
}

output "kubernetes_version" {
  description = "Actual Kubernetes version (with patch, e.g. 1.32.2-do.0)."
  value       = digitalocean_kubernetes_cluster.this.version
}

output "node_pool_id" {
  description = "UUID of the default node pool."
  value       = digitalocean_kubernetes_cluster.this.node_pool[0].id
}

# --------------------------------------------------------------------------
# kubeconfig
# --------------------------------------------------------------------------
# kubeconfig contains a Bearer token — treat as sensitive.
# sensitive = true prevents Terraform from printing the value during apply/plan.
# To retrieve: `tofu output -raw kubeconfig > ~/.kube/config`
output "kubeconfig" {
  description = "Raw kubeconfig in YAML format. Retrieve with: tofu output -raw kubeconfig > ~/.kube/config"
  value       = digitalocean_kubernetes_cluster.this.kube_config[0].raw_config
  sensitive   = true
}

output "cluster_ca_certificate" {
  description = "Base64-encoded cluster CA certificate."
  value       = digitalocean_kubernetes_cluster.this.kube_config[0].cluster_ca_certificate
  sensitive   = true
}

output "kube_config_token" {
  description = "Bearer token for Kubernetes API authentication."
  value       = digitalocean_kubernetes_cluster.this.kube_config[0].token
  sensitive   = true
}

output "kube_config_host" {
  description = "Kubernetes API server URL (from kube_config block)."
  value       = digitalocean_kubernetes_cluster.this.kube_config[0].host
}

output "kube_config_expires_at" {
  description = "Token expiry date (ISO 8601)."
  value       = digitalocean_kubernetes_cluster.this.kube_config[0].expires_at
}