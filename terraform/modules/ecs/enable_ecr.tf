data "docker_registry_image" "dibbs" {
  for_each = var.enable_ecr == true ? local.service_data : {}
  name     = "ghcr.io/cdcgov/phdi/${each.key}:${each.value.app_version}"
}

resource "docker_image" "dibbs" {
  for_each      = var.enable_ecr == true ? local.service_data : {}
  name          = data.docker_registry_image.dibbs[each.key].name
  keep_locally  = true
  pull_triggers = [data.docker_registry_image.dibbs[each.key].sha256_digest, plantimestamp()]
  force_remove  = true
}

resource "docker_tag" "this" {
  for_each     = var.enable_ecr == true ? local.service_data : {}
  source_image = docker_image.dibbs[each.key].name
  target_image = "${each.value.registry_url}/${each.value.app_image}:${each.value.app_version}"
  lifecycle {
    replace_triggered_by = [
      null_resource.docker_tag
    ]
  }
}

resource "docker_registry_image" "this" {
  for_each = var.enable_ecr == true ? local.service_data : {}
  name     = "${each.value.registry_url}/${each.value.app_image}:${each.value.app_version}"
  depends_on = [
    docker_image.dibbs,
    docker_tag.this,
    aws_ecr_repository.this
  ]
  keep_remotely = true

  triggers = {
    sha256_digest = data.docker_registry_image.dibbs[each.key].sha256_digest
  }
}

resource "null_resource" "docker_tag" {
  for_each = docker_image.dibbs
  triggers = {
    docker_image = each.value.id
  }
}

data "aws_ecr_authorization_token" "this" {}

resource "aws_ecr_repository" "this" {
  for_each     = var.enable_ecr == true ? local.service_data : {}
  name         = each.value.app_image
  force_delete = true
  tags = local.tags
}