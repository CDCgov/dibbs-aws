terraform {
  backend "s3" {}
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "=5.70.0"
    }
  }
}
provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      owner       = "skylight"
      environment = "tfstate"
      project     = "dibbs"
    }
  }
}
