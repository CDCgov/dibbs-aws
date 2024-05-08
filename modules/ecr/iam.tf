resource "aws_iam_policy" "ecr_policy" {
  name        = "ecr-access-policy"
  description = "Allow ECS tasks to access ECR"
  policy      = data.aws_iam_policy_document.ecr_policy.json
}

/*resource "aws_iam_role_policy_attachment" "attach_ecr_policy" {
  policy_arn = aws_iam_policy.ecr_policy.arn
  role       = var.ecs_task_execution_role_name
}*/
