resource "aws_cloudwatch_log_group" "ecs_cloudwatch_logs" {
  name              = var.ecs_cloudwatch_log_group
  retention_in_days = var.retention_in_days
}

resource "aws_flow_log" "ecs_flow_log" {
  depends_on = [var.vpc_id] # Ensure the VPC is created before creating flow logs

  # ID of the VPC to associate the flow log with
  vpc_id = var.vpc_id

  # ARN of the IAM role that the flow log will assume to publish logs to CloudWatch Logs
  iam_role_arn = var.ecs_task_execution_role_arn

  # The type of traffic to capture. Valid values are ACCEPT, REJECT, or ALL.
  traffic_type = "ALL"

  # The ARN of the CloudWatch Logs group where the flow logs will be published
  log_destination = aws_cloudwatch_log_group.ecs_cloudwatch_logs.arn

  # IAM policy document for the IAM role assumed by the flow log
  # Replace this with your own policy document as needed
  log_destination_type = "cloud-watch-logs"
}

