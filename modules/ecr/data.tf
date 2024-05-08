data "aws_ecr_repository" "default" {
  name = var.ecr_repo_name
}

data "aws_iam_policy_document" "ecr_policy" {
  statement {
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
    ]
    resources = ["arn:aws:ecs:us-east-1:339712971032:cluster/dibbs-ecs-cluster"]
  }
}