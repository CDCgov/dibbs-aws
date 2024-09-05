resource "aws_cloudwatch_log_group" "ecs_cloudwatch_logs" {
  name              = local.ecs_cloudwatch_group
  retention_in_days = var.cw_retention_in_days
  tags              = local.tags
}

resource "aws_flow_log" "ecs_flow_log" {
  vpc_id               = var.vpc_id
  iam_role_arn         = aws_iam_role.ecs_task_execution.arn
  traffic_type         = "ALL"
  log_destination      = aws_cloudwatch_log_group.ecs_cloudwatch_logs.arn
  log_destination_type = "cloud-watch-logs"
  tags                 = local.tags
}
