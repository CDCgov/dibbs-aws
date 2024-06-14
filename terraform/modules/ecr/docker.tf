# Pull images from GitHub Container Registry and push to AWS Elastic Container Registry

resource "time_static" "now" {}

# NOTE: This pulls image down from the docker registry
resource "docker_image" "ghcr_image" {
  for_each      = local.images
  name          = data.docker_registry_image.ghcr_data[each.key].name
  keep_locally  = true
  pull_triggers = [data.docker_registry_image.ghcr_data[each.key].sha256_digest]
}

resource "docker_tag" "tag_for_aws" {
  for_each     = local.images
  source_image = docker_image.ghcr_image[each.key].name
  target_image = "${aws_ecr_repository.repo[each.key].repository_url}:${local.phdi_version}"
}

resource "docker_registry_image" "my_docker_image" {
  for_each      = local.images
  name          = "${aws_ecr_repository.repo[each.key].repository_url}:${local.phdi_version}"
  depends_on    = [docker_tag.tag_for_aws, aws_ecr_repository.repo]
  keep_remotely = true

  triggers = {
    sha256_digest = data.docker_registry_image.ghcr_data[each.key].sha256_digest
  }
}
