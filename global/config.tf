terraform {
  backend "s3" {
    bucket = "pythonpizza-global-terraform"
    key    = "global/terraform.tfstate"
    region = "eu-central-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.23.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "2.17.0"
    }
    github = {
      source  = "integrations/github"
      version = "4.2.0"
    }
  }

  required_version = ">= 0.13"
}

provider "aws" {
  region = "eu-central-1"
}

provider "github" {
  token = var.github_token
  owner = "pythonpizza"
}

provider "cloudflare" {
  api_token = var.cloudflare_token
}
