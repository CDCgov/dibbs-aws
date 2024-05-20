data "aws_iam_policy_document" "ecr_policy" {

  for_each = var.ecr_repo_name
  statement {
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
    ]

    resources = ["arn:aws:ecs:us-east-1:339712971032:cluster/dibbs-ecs-cluster/${each.value}}"]
  }
}

data "docker_registry_image" "ghcr_data" {
  for_each = local.images
  name     = "ghcr.io/cdcgov/phdi/${each.key}:${local.phdi_version}"
}

data "aws_ecr_authorization_token" "container_registry_token" {}
