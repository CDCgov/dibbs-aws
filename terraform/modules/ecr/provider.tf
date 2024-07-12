terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {
  # Note: Terraform will automatically communicate with the local 
  # Docker daemon using the default Unix socket 
  host = "unix:///var/run/docker.sock"

  registry_auth {

    address  = data.aws_ecr_authorization_token.container_registry_token.proxy_endpoint
    username = data.aws_ecr_authorization_token.container_registry_token.user_name
    password = data.aws_ecr_authorization_token.container_registry_token.password

    config_file_content = jsonencode({
      "auths" = {
        "${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com" = {}
      }
      "credHelpers" = {
        "${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com" = "ecr-login"
      }
    })
  }
}
