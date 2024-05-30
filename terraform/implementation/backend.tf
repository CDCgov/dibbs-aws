terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "=5.31.0"
    }
  }

  backend "s3" {
    key    = "remote_tfstate"
    region = "us-east-1"
  }
}

# Credentials should be provided by using the AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY environment variables.
provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      Owner       = "Skylight"
      Environment = terraform.workspace
    }
  }
}
