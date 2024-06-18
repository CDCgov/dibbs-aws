output "ecs_task_execution_role" {
  value = aws_iam_role.ecs_task_execution_role
}

output "ecr_viewer_and_s3_assume_role_policy" {
  value = data.aws_iam_policy_document.ecr_viewer_and_s3_assume_role_policy.json
}
