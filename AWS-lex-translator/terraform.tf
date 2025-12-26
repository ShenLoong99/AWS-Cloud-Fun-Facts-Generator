terraform {
  required_version = ">= 1.0.0"

  backend "remote" {
      hostname     = "app.terraform.io"
      organization = "my-terraform-aws-projects-2025"

      workspaces {
      name = "AWS-lex-translator"
      }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.0"
    }
  }
}