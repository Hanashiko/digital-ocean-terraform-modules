terraform {
  required_version = ">= 1.6.0" # OpenTofu 1.6+ or Terraform 1.6+

  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }

  # Uncomment and configure the backend for your stack.
  # For S3-compatible storage (DigitalOcean Spaces or AWS S3):
  #
  # backend "s3" {
  #   endpoint                    = "https://fra1.digitaloceanspaces.com"
  #   bucket                      = "my-tofu-state"
  #   key                         = "doks/dev/terraform.tfstate"
  #   region                      = "us-east-1"          # dummy but required by the S3 provider
  #   skip_credentials_validation = true
  #   skip_metadata_api_check     = true
  #   skip_region_validation      = true
  #   force_path_style            = true
  #   # credentials via env: AWS_ACCESS_KEY_ID / AWS_SECRET_ACCESS_KEY or via profile
  # }
}

provider "digitalocean" {
  # Token is read from DIGITALOCEAN_TOKEN env var or the token variable.
  # Never hardcode the token in .tf files — use env or SOPS.
  # token = var.do_token  # if passing via variable
}