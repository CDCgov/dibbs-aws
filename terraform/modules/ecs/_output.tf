# service data

output "service_data" {
  value = local.service_data
}

# s3

output "s3_bucket_arn" {
  value       = aws_s3_bucket.ecr_viewer.arn
  description = "The ARN of the S3 bucket"
}

# ecs

output "ecs_cluster_arn" {
  value = aws_ecs_cluster.dibbs_app_cluster.arn
}

output "ecs_task_definitions_arns" {
  value = { for task_name, task_def in aws_ecs_task_definition.this : task_name => task_def.arn }
}

# iam

output "ecs_task_execution_role_arn" {
  value = aws_iam_role.ecs_task_execution.arn
}

output "ecs_task_role_arn" {
  value = aws_iam_role.ecs_task.arn
}

output "s3_role_for_ecr_viewer_arn" {
  value = aws_iam_role.s3_role_for_ecr_viewer.arn
}

output "s3_bucket_ecr_viewer_policy_arn" {
  value = aws_iam_policy.s3_bucket_ecr_viewer.arn
}

# alb

output "alb_arn" {
  value = aws_alb.ecs.arn
}

output "alb_target_groups_arns" {
  value = { for tg_name, tg in aws_alb_target_group.this : tg_name => tg.arn }
}

output "alb_listener_arn" {
  value = aws_alb_listener.http.arn
}

output "alb_listener_rules_arns" {
  value = { for rule_name, rule in aws_alb_listener_rule.this : rule_name => rule.arn }
}

output "ecs_security_group_arn" {
  value = aws_security_group.ecs.arn
}

output "alb_security_group_arn" {
  value = aws_security_group.alb.arn
}
