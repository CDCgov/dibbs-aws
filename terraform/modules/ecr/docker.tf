resource "time_static" "now" {}

resource "docker_image" "ghcr_image" {
  for_each      = var.service_data
  name          = data.docker_registry_image.ghcr_data[each.key].name
  keep_locally  = true
  pull_triggers = [data.docker_registry_image.ghcr_data[each.key].sha256_digest, plantimestamp()]
  force_remove  = true
}

resource "docker_tag" "tag_for_aws" {
  for_each     = var.service_data
  source_image = docker_image.ghcr_image[each.key].name
  target_image = "${aws_ecr_repository.repository_urls[each.key].repository_url}:${each.value.app_version}"
  lifecycle {
    replace_triggered_by = [
      null_resource.docker_tag
    ]
  }
}

resource "docker_registry_image" "my_docker_image" {
  for_each = var.service_data
  name     = "${aws_ecr_repository.repository_urls[each.key].repository_url}:${each.value.app_version}"
  depends_on = [
    docker_image.ghcr_image,
    docker_tag.tag_for_aws,
    aws_ecr_repository.repository_urls
  ]
  keep_remotely = true

  triggers = {
    sha256_digest = data.docker_registry_image.ghcr_data[each.key].sha256_digest
  }
}

resource "null_resource" "docker_tag" {
  for_each = docker_image.ghcr_image
  triggers = {
    docker_image = each.value.id
  }
}
