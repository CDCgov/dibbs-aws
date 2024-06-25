data "docker_registry_image" "ghcr_data" {
  for_each = var.service_data
  name     = "ghcr.io/cdcgov/phdi/${each.key}:${var.phdi_version}"
}

data "aws_ecr_authorization_token" "container_registry_token" {}
