terraform {
  required_providers {
    dockerless = {
      source  = "nullstone-io/dockerless"
      version = "0.1.1"
    }
  }
}

provider "dockerless" {
  registry_auth = {
    "${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com" = {
      username = local.registry_username
      password = local.registry_password
    }
  }
}
