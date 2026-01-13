terraform {
  required_version = "~> 1.9.0"
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
      project     = var.project
      environment = terraform.workspace
    }
  }
}

provider "aws" {
  alias  = "replication"
  region = "us-west-2"
}
