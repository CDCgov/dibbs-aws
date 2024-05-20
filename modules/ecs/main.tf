resource "aws_ecs_cluster" "main" {
  name = var.ecs_cluster_name

  configuration {

    execute_command_configuration {
      logging = "OVERRIDE"
      log_configuration {
        cloud_watch_log_group_name = aws_cloudwatch_log_group.ecs_cloudwatch_logs.name
      }
    }
  }
}
