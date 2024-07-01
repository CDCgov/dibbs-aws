data "docker_registry_image" "ghcr_data" {
  for_each = var.service_data
  name     = "ghcr.io/cdcgov/phdi/${each.key}:${each.value.app_version}"
}

data "aws_ecr_authorization_token" "container_registry_token" {}

data "aws_caller_identity" "current" {}