variable "cluster_name" {
  description = "Cluster name."
  type        = string
  default     = "zomro-dev"
}

variable "region" {
  description = "DigitalOcean region."
  type        = string
  default     = "fra1"
}

variable "kubernetes_version" {
  description = <<-EOT
    Kubernetes version. Available versions:
      doctl kubernetes options versions
    Example: "1.32.2-do.0"
  EOT
  type        = string
  # No default — version must be explicitly set in tfvars to avoid unexpected drift on plan.
}

variable "env" {
  description = "Environment name (dev, staging, prod). Used for tags and labels."
  type        = string
  default     = "dev"
}

# Optional: pass the token as a variable instead of env
# variable "do_token" {
#   description = "DigitalOcean API token."
#   type        = string
#   sensitive   = true
# }