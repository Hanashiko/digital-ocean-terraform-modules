terraform {
  required_version = ">= 1.6.0" # OpenTofu 1.6+ або Terraform 1.6+

  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }

  # Розкоментуй і налаштуй бекенд під свій стек.
  # Для S3-compatible (DigitalOcean Spaces або AWS S3):
  #
  # backend "s3" {
  #   endpoint                    = "https://fra1.digitaloceanspaces.com"
  #   bucket                      = "my-tofu-state"
  #   key                         = "doks/dev/terraform.tfstate"
  #   region                      = "us-east-1"          # фіктивний, але обов'язковий для S3 provider
  #   skip_credentials_validation = true
  #   skip_metadata_api_check     = true
  #   skip_region_validation      = true
  #   force_path_style            = true
  #   # credentials — через env: AWS_ACCESS_KEY_ID / AWS_SECRET_ACCESS_KEY
  #   # або через profile
  # }
}

provider "digitalocean" {
  # Токен береться з env DIGITALOCEAN_TOKEN або змінної token.
  # Ніколи не хардкодь токен у .tf файлах — використовуй env або SOPS.
  # token = var.do_token  # якщо передаєш через змінну
}