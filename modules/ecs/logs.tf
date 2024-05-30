resource "aws_cloudwatch_log_group" "ecs_cloudwatch_logs" {
  name              = var.aws_cloudwatch_log_group
  retention_in_days = var.retention_in_days
}
