output "cluster_id" {
  description = "Cluster UUID."
  value       = module.doks.cluster_id
}

output "cluster_name" {
  value = module.doks.cluster_name
}

output "cluster_endpoint" {
  description = "Kubernetes API endpoint."
  value       = module.doks.cluster_endpoint
}

output "cluster_status" {
  value = module.doks.cluster_status
}

output "kubernetes_version" {
  value = module.doks.kubernetes_version
}

output "kube_config_host" {
  value     = module.doks.kube_config_host
  sensitive = true
}

output "kube_config_expires_at" {
  description = "kubeconfig token expiry date."
  value       = module.doks.kube_config_expires_at
  sensitive   = true
}

output "kubeconfig" {
  description = "Raw kubeconfig YAML. Save with: tofu output -raw kubeconfig > ~/.kube/config && chmod 600 ~/.kube/config"
  value     = module.doks.kubeconfig
  sensitive = true
}

output "cluster_ca_certificate" {
  value     = module.doks.cluster_ca_certificate
  sensitive = true
}

output "kube_config_token" {
  value     = module.doks.kube_config_token
  sensitive = true
}