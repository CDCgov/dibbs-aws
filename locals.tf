locals {
  alb_sg           = "app-lb-sg"
  app_service_name = "dibbs-aws-ecs-service"

  app_task_family                = "app-task_family"
  app_task_name                  = "app-task"
  application_load_balancer_name = "dibbs-aws-app-alb"
  availability_zones             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  aws_region                     = "us-east-1"

  container_port = 8080

  #ecs_task_execution_role = "app-task-execution-role"
  ecr_repo_name = [
    "fhir-converter",
    "ingestion",
    "message-parser",
    "orchestration"
  ]

  ecs_task_execution_role_name = "dibbs-aws-ecs-task-execution-role"
  name                         = "dibbs-aws-${terraform.workspace}"
  retention_in_days            = "30"
  aws_cloudwatch_log_group     = "/ecs-cloudwatch-logs"

  target_group_name   = "dibbs-ecs-alb-target-group" #changed from dibbs-aws-alb-tg
  ecs_app_task_family = "dibbs-aws-ecs-task-family"


}
