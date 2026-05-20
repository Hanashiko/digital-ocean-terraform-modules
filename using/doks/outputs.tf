output "cluster_id" {
  description = "UUID кластера."
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
  description = "Коли закінчується токен kubeconfig."
  value       = module.doks.kube_config_expires_at
  sensitive   = true
}

# sensitive outputs — не відображаються автоматично, тільки явно
output "kubeconfig" {
  description = <<-EOT
    Raw kubeconfig YAML. Зберегти:
      tofu output -raw kubeconfig > ~/.kube/config
      chmod 600 ~/.kube/config
  EOT
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