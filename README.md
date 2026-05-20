# DOKS Terraform/OpenTofu Module

Minimal DOKS cluster: 1 node, `s-1vcpu-2gb` (1 vCPU / 2 GB RAM / 50 GB SSD).

## Structure

```
.
├── modules/
│   └── doks/
│       ├── main.tf       # digitalocean_kubernetes_cluster resource
│       ├── variables.tf  # all input variables with descriptions and validation
│       └── outputs.tf    # cluster_id, endpoint, kubeconfig (sensitive), etc.
└── using/
    └── doks/
        ├── versions.tf        # required_providers + backend
        ├── main.tf            # module call
        ├── variables.tf       # environment variables
        ├── outputs.tf         # proxy outputs from the module
        └── terraform.tfvars   # values (no secrets)
```

## Prerequisites

```bash
# OpenTofu >= 1.6
tofu version

# doctl to check available versions and sizes
doctl kubernetes options versions
doctl kubernetes options sizes | grep "s-1vcpu"

# Set token
export DIGITALOCEAN_TOKEN="dop_v1_..."
```

## Usage

```bash
cd using/doks

# Initialize (downloads the digitalocean provider)
tofu init

# Preview the plan
tofu plan

# Apply (~5-8 minutes for provisioning)
tofu apply

# Retrieve kubeconfig after apply
tofu output -raw kubeconfig > ~/.kube/config
chmod 600 ~/.kube/config

# Verify
kubectl get nodes
```

## Outputs

| Output | Type | Sensitive | Description |
|--------|------|-----------|-------------|
| `cluster_id` | string | no | Cluster UUID |
| `cluster_name` | string | no | Cluster name |
| `cluster_endpoint` | string | no | API server URL |
| `cluster_status` | string | no | running / provisioning |
| `kubernetes_version` | string | no | Full version with patch |
| `kube_config_host` | string | no | API host from kubeconfig |
| `kube_config_expires_at` | string | no | Token expiry date |
| `kubeconfig` | string | **yes** | Raw YAML kubeconfig |
| `cluster_ca_certificate` | string | **yes** | Base64 CA cert |
| `kube_config_token` | string | **yes** | Bearer token |

## Notes

- **kubeconfig token** has a TTL of ~7 days. Renew via `doctl` or re-run `tofu apply` (if the provider refreshes `kube_config`).
- **`s-1vcpu-2gb`** is the absolute minimum for DOKS. System overhead (kube-proxy, CoreDNS, metrics-server, DigitalOcean agents) leaves ~1.2-1.4 GB RAM available for workloads.
- For prod: minimum recommended size is `s-2vcpu-4gb`, with HA control plane and `surge_upgrade = true`.