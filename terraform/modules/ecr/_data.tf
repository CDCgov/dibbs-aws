data "aws_iam_policy_document" "ecr_policy" {

  for_each = var.service_data
  statement {
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
    ]

    resources = ["arn:aws:ecs:${var.region}:${var.aws_caller_identity}:cluster/${var.ecs_cluster_name}/${each.key}"]
  }
}

data "docker_registry_image" "ghcr_data" {
  for_each = var.service_data
  name     = "ghcr.io/cdcgov/phdi/${each.key}:${var.phdi_version}"
}

data "aws_ecr_authorization_token" "container_registry_token" {}
