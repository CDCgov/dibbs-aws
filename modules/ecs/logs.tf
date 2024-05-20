resource "aws_cloudwatch_log_group" "ecs_cloudwatch_logs" {
  name              = "/ecs-cloudwatch-logs"
  retention_in_days = var.retention_in_days
}
