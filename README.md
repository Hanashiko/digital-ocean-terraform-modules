# DOKS Terraform/OpenTofu Module

Мінімальний DOKS кластер: 1 нода, `s-1vcpu-2gb` (1 vCPU / 2 GB RAM / 50 GB SSD).

## Структура

```
.
├── modules/
│   └── doks/
│       ├── main.tf       # digitalocean_kubernetes_cluster resource
│       ├── variables.tf  # всі вхідні змінні з описами і валідацією
│       └── outputs.tf    # cluster_id, endpoint, kubeconfig (sensitive), тощо
└── envs/
    └── dev/
        ├── versions.tf        # required_providers + backend
        ├── main.tf            # виклик модуля
        ├── variables.tf       # змінні оточення
        ├── outputs.tf         # proxy outputs з модуля
        └── terraform.tfvars   # значення (без секретів)
```

## Передумови

```bash
# OpenTofu >= 1.6
tofu version

# doctl для перевірки доступних версій і розмірів
doctl kubernetes options versions
doctl kubernetes options sizes | grep "s-1vcpu"

# Встановити токен
export DIGITALOCEAN_TOKEN="dop_v1_..."
```

## Використання

```bash
cd envs/dev

# Ініціалізація (завантажить digitalocean provider)
tofu init

# Перевірка плану
tofu plan

# Застосування (~5-8 хвилин на provisioning)
tofu apply

# Отримати kubeconfig після apply
tofu output -raw kubeconfig > ~/.kube/config
chmod 600 ~/.kube/config

# Перевірити
kubectl get nodes
```

## Outputs

| Output | Тип | Sensitive | Опис |
|--------|-----|-----------|------|
| `cluster_id` | string | ні | UUID кластера |
| `cluster_name` | string | ні | Назва |
| `cluster_endpoint` | string | ні | API server URL |
| `cluster_status` | string | ні | running / provisioning |
| `kubernetes_version` | string | ні | Повна версія з patch |
| `kube_config_host` | string | ні | API host з kubeconfig |
| `kube_config_expires_at` | string | ні | Дата закінчення токена |
| `kubeconfig` | string | **так** | Raw YAML kubeconfig |
| `cluster_ca_certificate` | string | **так** | Base64 CA cert |
| `kube_config_token` | string | **так** | Bearer token |

## Нотатки

- **kubeconfig токен** має TTL ~7 днів. Після закінчення оновлюється через `doctl` або повторний `tofu apply` (якщо провайдер оновить `kube_config`).
- **`s-1vcpu-2gb`** — абсолютний мінімум для DOKS. На цій ноді запущений і system overhead (kube-proxy, CoreDNS, metrics-server, цифроокеанські агенти), тому реально під workload залишається ~1.2-1.4 GB RAM.
- Для prod: мінімально рекомендований розмір `s-2vcpu-4gb`, HA control plane, `surge_upgrade = true`.