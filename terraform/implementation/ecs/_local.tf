locals {
  service_data = {
    ecr-viewer = {
      fargate_cpu    = 1024,
      fargate_memory = 2048,
      app_image      = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com/ecr-viewer:${var.phdi_version}",
      container_port = 3000,
      host_port      = 3000,
      public         = true
      env_vars       = []
    },
    fhir-converter = {
      fargate_cpu    = 1024,
      fargate_memory = 2048,
      app_image      = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com/fhir-converter:${var.phdi_version}",
      container_port = 8080,
      host_port      = 8080,
      public         = false
      env_vars       = []
    },
    ingestion = {
      fargate_cpu    = 1024,
      fargate_memory = 2048,
      app_image      = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com/ingestion:${var.phdi_version}",
      container_port = 8080,
      host_port      = 8080,
      public         = false
      env_vars       = []
    },
    validation = {
      fargate_cpu    = 1024,
      fargate_memory = 2048,
      app_image      = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com/validation:${var.phdi_version}",
      container_port = 8080,
      host_port      = 8080,
      public         = false
      env_vars       = []
    },
    orchestration = {
      fargate_cpu    = 1024,
      fargate_memory = 2048,
      app_image      = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com/orchestration:${var.phdi_version}",
      container_port = 8080,
      host_port      = 8080,
      public         = true
      env_vars = [
        {
          name  = "APPMESH_VIRTUAL_NODE_NAME",
          value = "orchestration"
        },
        {
          name  = "INGESTION_URL",
          value = "http://ingestion:8080"
        },
        {
          name  = "VALIDATION_URL",
          value = "http://validation:8080"
        },
        {
          name  = "FHIR_CONVERTER_URL",
          value = "http://fhir-converter:8080"
        },
        {
          name  = "ECR_VIEWER_URL",
          value = "http://ecr-viewer:3000"
        },
        {
          name  = "MESSAGE_PARSER_URL",
          value = "http://message-parser-not-implemented:8080"
        }
      ]
    }
  }

  ecs_alb_sg                   = "${var.ecs_alb_sg}-${var.owner}-${terraform.workspace}"
  ecs_alb_name                 = "${var.ecs_alb_name}-${var.owner}-${terraform.workspace}"
  ecs_app_service_name         = "${var.ecs_app_service_name}-${var.owner}-${terraform.workspace}"
  ecs_app_task_name            = "${var.ecs_app_task_name}-${var.owner}-${terraform.workspace}"
  ecs_task_execution_role_name = "${var.ecs_task_execution_role_name}-${var.owner}-${terraform.workspace}"
  ecs_cloudwatch_log_group     = "${var.ecs_cloudwatch_log_group}-${var.owner}-${terraform.workspace}"
  ecs_target_group_name        = "${var.ecs_target_group_name}-${var.owner}-${terraform.workspace}"
  ecs_app_task_family          = "${var.ecs_app_task_family}-${var.owner}-${terraform.workspace}"
  ecs_cluster_name             = "${var.ecs_cluster_name}-${var.owner}-${terraform.workspace}"
  s3_viewer_bucket_name        = "${var.s3_viewer_bucket_name}-${var.owner}-${terraform.workspace}"
  s3_viewer_bucket_role_name   = "${var.s3_viewer_bucket_role_name}-${var.owner}-${terraform.workspace}"
  s3_viewer_bucket_policy_name = "${var.s3_viewer_bucket_policy_name}-${var.owner}-${terraform.workspace}"
  vpc                          = "${var.vpc}-${var.owner}-${terraform.workspace}"

  enable_nat_gateway = var.enable_nat_gateway
  single_nat_gateway = var.single_nat_gateway
  availability_zones = var.availability_zones
}
