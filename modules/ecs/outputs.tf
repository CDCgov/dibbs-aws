output "alb_hostname" {
  value = "${aws_alb.main.dns_name}:3000"
}

output "ecs_task_execution_role" {
  value = "{aws_iam_role.ecs_task_execution_role}"
}

output "ecs_task_execution_role_name" {
  value = "{aws_iam_role.ecs_task_execution_role}.name"
}