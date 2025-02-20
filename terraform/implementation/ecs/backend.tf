terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.86.0"
    }
  }

  backend "s3" {
    key     = "remote_tfstate"
    encrypt = true
    # dynamodb_table
    # bucket
    # region
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
