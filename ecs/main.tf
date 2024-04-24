resource "aws_ecs_cluster" "ecs_cluster" {
 name = "dibbs-ecs-cluster"
}

resource "aws_cloudwatch_log_group" "log_group" {
  name              = "dibbs-ecs-log-group"
  retention_in_days = var.retention_in_days
  tags              = var.tags
}