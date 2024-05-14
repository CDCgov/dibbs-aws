resource "aws_iam_policy" "ecr_policy" {
  name        = "ecr-access-policy"
  description = "Allow ECS tasks to access ECR"
  policy      = data.aws_iam_policy_document.ecr_policy[each.key].json
}
