terraform {
  backend "s3" {
    bucket = "pythonpizza-terraform"
    key    = "event-website/terraform.tfstate"
    region = "eu-central-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.23.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "2.10.0"
    }
  }

  required_version = ">= 0.13"
}

provider "aws" {
  region = "eu-central-1"
}

provider "cloudflare" {
  api_token = var.cloudflare_token
}
