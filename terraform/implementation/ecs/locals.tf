locals {
  ecs_container_port = 8080
  ecr_repos = [
    "fhir-converter",
    "ingestion",
    "message-parser",
    "orchestration"
  ]

  ecs_alb_sg                   = "${var.ecs_alb_sg}-${var.owner}-${terraform.workspace}"
  ecs_alb_name                 = "${var.ecs_alb_name}-${var.owner}-${terraform.workspace}"
  ecs_app_service_name         = "${var.ecs_app_service_name}-${var.owner}-${terraform.workspace}"
  ecs_app_task_name            = "${var.ecs_app_task_name}-${var.owner}-${terraform.workspace}"
  ecs_task_execution_role_name = "${var.ecs_task_execution_role_name}-${var.owner}-${terraform.workspace}"
  ecs_cloudwatch_log_group     = "${var.ecs_cloudwatch_log_group}-${var.owner}-${terraform.workspace}"
  ecs_target_group_name        = "${var.ecs_target_group_name}-${var.owner}-${terraform.workspace}"
  ecs_app_task_family          = "${var.ecs_app_task_family}-${var.owner}-${terraform.workspace}"
  vpc                          = "${var.vpc}-${var.owner}-${terraform.workspace}"

  enable_nat_gateway = var.enable_nat_gateway
  single_nat_gateway = var.single_nat_gateway
  availability_zones = var.availability_zones
  ghcr_token         = var.ghcr_token
  ghcr_username      = var.ghcr_username
}
