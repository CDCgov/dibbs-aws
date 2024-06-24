resource "time_static" "now" {}

resource "docker_image" "ghcr_image" {
  for_each      = var.service_data
  name          = data.docker_registry_image.ghcr_data[each.key].name
  keep_locally  = true
  pull_triggers = [data.docker_registry_image.ghcr_data[each.key].sha256_digest]
  force_remove  = true
}

resource "docker_tag" "tag_for_aws" {
  for_each     = var.service_data
  source_image = docker_image.ghcr_image[each.key].name
  target_image = "${aws_ecr_repository.repo[each.key].repository_url}:${var.phdi_version}"
}

resource "docker_registry_image" "my_docker_image" {
  for_each      = var.service_data
  name          = "${aws_ecr_repository.repo[each.key].repository_url}:${var.phdi_version}"
  depends_on    = [docker_tag.tag_for_aws, aws_ecr_repository.repo]
  keep_remotely = true

  triggers = {
    sha256_digest = data.docker_registry_image.ghcr_data[each.key].sha256_digest
  }
}
