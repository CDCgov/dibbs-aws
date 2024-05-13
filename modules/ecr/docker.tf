# Pull images from GitHub Container Registry and push to Azure Container Registry
locals {
  images = toset([
    "fhir-converter",
    "ingestion",
    "message-parser",
    "orchestration",
  ])

  # NOTE: The version may need to be changed with updates
  phdi_version = "v1.1.7"
}

resource "time_static" "now" {}

resource "docker_registry_image" "my_docker_image" {
  for_each      = local.images
  name          = "${aws_ecr_repository.repo.repository_url}/phdi/${each.key}:${local.phdi_version}"
  depends_on    = [docker_tag.tag_for_aws]
  keep_remotely = true

  triggers = {
    sha256_digest = data.docker_registry_image.ghcr_data[each.key].sha256_digest
  }
}

# NOTE: This pulls this down from the docker registry
resource "docker_image" "ghcr_image" {
  for_each      = local.images
  name          = data.docker_registry_image.ghcr_data[each.key].name
  keep_locally  = true
  pull_triggers = [data.docker_registry_image.ghcr_data[each.key].sha256_digest]
}

resource "docker_tag" "tag_for_aws" {
  for_each     = local.images
  source_image = docker_image.ghcr_image[each.key].name
  target_image = "${aws_ecr_repository.repo.repository_url}/phdi/${each.key}:${local.phdi_version}"
}


