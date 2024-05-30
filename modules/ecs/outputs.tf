output "alb_hostname" {
  value = "${aws_alb.main.dns_name}:8080"
}

output "ecs_task_execution_role" {
  value = aws_iam_role.ecs_task_execution_role
}

output "ecs_task_execution_role_name" {
  value = aws_iam_role.ecs_task_execution_role
}

output "ecs_cluster_arn" {
  value = aws_ecs_cluster.dibbs_app_cluster.arn
}
