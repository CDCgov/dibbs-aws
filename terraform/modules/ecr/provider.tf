terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.1"
    }
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
        "${var.aws_caller_identity}.dkr.ecr.${var.region}.amazonaws.com" = {}
      }
      "credHelpers" = {
        "${var.aws_caller_identity}.dkr.ecr.${var.region}.amazonaws.com" = "ecr-login"
      }
    })
  }
}
