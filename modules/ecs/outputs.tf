output "alb_hostname" {
  value = "${aws_alb.main.dns_name}:8080"
}

output "ecs_task_execution_role" {
  value = "{aws_iam_role.ecs_task_execution_role}"
}

output "ecs_task_execution_role_name" {
  value = "{aws_iam_role.ecs_task_execution_role}.name"
}

output "ecr_repo_name" {
  value = "{aws_ecr_repository.ecr_repo_name}.name"
}
