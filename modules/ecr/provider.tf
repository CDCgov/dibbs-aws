terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.1"
    }

    # aws = {
    #   version = ">= 5.30.0"
    # }
  }
}

provider "docker" {
  # Note: Terraform will automatically communicate with the local 
  # Docker daemon using the default Unix socket 
  host = "unix:///var/run/docker.sock"

  registry_auth {
    address  = "ghcr.io"
    username = var.ghcr_username
    password = var.ghcr_token
  }

  registry_auth {

    address  = data.aws_ecr_authorization_token.container_registry_token.proxy_endpoint
    username = data.aws_ecr_authorization_token.container_registry_token.user_name
    password = data.aws_ecr_authorization_token.container_registry_token.password

    config_file_content = jsonencode({
      "auths" = {
        "339712971032.dkr.ecr.us-east-1.amazonaws.com" = {}
      }
      "credHelpers" = {
        "339712971032.dkr.ecr.us-east-1.amazonaws.com" = "ecr-login"
      }
    })
  }
}

data "aws_ecr_authorization_token" "token" {
}
