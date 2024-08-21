resource "random_string" "s3_viewer" {
  length  = 8
  special = false
  upper   = false
}

locals {
  service_data = {
    ecr-viewer = {
      short_name     = "ecrv",
      fargate_cpu    = 1024,
      fargate_memory = 2048,
      app_count      = 1
      app_image      = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com/${terraform.workspace}-ecr-viewer",
      app_version    = var.phdi_version,
      container_port = 3000,
      host_port      = 3000,
      public         = true
      env_vars = [
        {
          name  = "AWS_REGION",
          value = var.region
        },
        {
          name  = "ECR_BUCKET_NAME",
          value = local.s3_viewer_bucket_name
        },
        {
          name  = "HOSTNAME",
          value = "0.0.0.0"
        },
        {
          name = "DATABASE_TYPE",
          value = var.ecr_viewer_database_type,
        },
        {
          name = "DATABASE_SCHEMA",
          value = var.ecr_viewer_database_schema,
        }
      ]
    },
    fhir-converter = {
      short_name     = "fhirc",
      fargate_cpu    = 1024,
      fargate_memory = 2048,
      app_count      = 1
      app_image      = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com/${terraform.workspace}-fhir-converter",
      app_version    = var.phdi_version,
      container_port = 8080,
      host_port      = 8080,
      public         = false
      env_vars       = []
    },
    ingestion = {
      short_name     = "inge",
      fargate_cpu    = 1024,
      fargate_memory = 2048,
      app_count      = 1
      app_image      = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com/${terraform.workspace}-ingestion",
      app_version    = var.phdi_version,
      container_port = 8080,
      host_port      = 8080,
      public         = false
      env_vars       = []
    },
    validation = {
      short_name     = "vali",
      fargate_cpu    = 1024,
      fargate_memory = 2048,
      app_count      = 1
      app_image      = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com/${terraform.workspace}-validation",
      app_version    = var.phdi_version,
      container_port = 8080,
      host_port      = 8080,
      public         = false
      env_vars       = []
    },
    trigger-code-reference = {
      short_name     = "trigcr",
      fargate_cpu    = 1024,
      fargate_memory = 2048,
      app_count      = 1
      app_image      = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com/${terraform.workspace}-trigger-code-reference",
      app_version    = var.phdi_version,
      container_port = 8080,
      host_port      = 8080,
      public         = false
      env_vars       = []
    },
    message-parser = {
      short_name     = "msgp",
      fargate_cpu    = 1024,
      fargate_memory = 2048,
      app_count      = 1
      app_image      = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com/${terraform.workspace}-message-parser",
      app_version    = var.phdi_version,
      container_port = 8080,
      host_port      = 8080,
      public         = false
      env_vars       = []
    },
    orchestration = {
      short_name     = "orch",
      fargate_cpu    = 1024,
      fargate_memory = 2048,
      app_count      = 1
      app_image      = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com/${terraform.workspace}-orchestration",
      app_version    = var.phdi_version,
      container_port = 8080,
      host_port      = 8080,
      public         = true
      env_vars = [
        {
          name  = "OTEL_METRICS",
          value = "none"
        },
        {
          name  = "OTEL_METRICS_EXPORTER",
          value = "none"
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
          value = "http://ecr-viewer:3000/ecr-viewer"
        },
        {
          name  = "MESSAGE_PARSER_URL",
          value = "http://message-parser:8080"
        },
        {
          name  = "TRIGGER_CODE_REFERENCE_URL",
          value = "http://trigger-code-reference:8080"
        }
      ]
    }
  }
  appmesh_name                 = "${var.project}-${var.appmesh_name}-${var.owner}-${terraform.workspace}"
  cloudmap_namespace_name      = "${var.project}-${var.cloudmap_namespace_name}-${var.owner}-${terraform.workspace}"
  cloudmap_service_name        = "${var.project}-${var.cloudmap_service_name}-${var.owner}-${terraform.workspace}"
  ecs_alb_sg                   = "${var.project}-${var.ecs_alb_sg}-${var.owner}-${terraform.workspace}"
  ecs_alb_name                 = "${var.project}-${var.ecs_alb_name}-${var.owner}-${terraform.workspace}"
  ecs_alb_tg_name              = "${var.project}-${var.owner}-${terraform.workspace}"
  ecs_task_execution_role_name = "${var.project}-${var.ecs_task_execution_role_name}-${var.owner}-${terraform.workspace}"
  ecs_task_role_name           = "${var.project}-${var.ecs_task_role_name}-${var.owner}-${terraform.workspace}"
  ecs_cloudwatch_group         = "/${var.project}-${var.ecs_cloudwatch_group}-${var.owner}-${terraform.workspace}"
  ecs_cluster_name             = "${var.project}-${var.ecs_cluster_name}-${var.owner}-${terraform.workspace}"
  s3_viewer_bucket_name        = "${var.project}-${var.s3_viewer_bucket_name}-${var.owner}-${terraform.workspace}-${random_string.s3_viewer.result}"
  s3_viewer_bucket_role_name   = "${var.project}-${var.s3_viewer_bucket_role_name}-${var.owner}-${terraform.workspace}"
  vpc_name                     = "${var.project}-${var.vpc}-${var.owner}-${terraform.workspace}"
}
