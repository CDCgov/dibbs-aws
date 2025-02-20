terraform {
  required_version = "~> 1.9.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.86.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6.3"
    }
    http = {
      source  = "hashicorp/http"
      version = "3.4.5"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      owner       = var.owner
      environment = terraform.workspace
      project     = var.project
    }
  }
}
