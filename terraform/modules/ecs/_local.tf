resource "random_string" "s3_viewer" {
  length  = 8
  special = false
  upper   = false
}

locals {
  registry_url      = var.disable_ecr == false ? "${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com" : "ghcr.io/cdcgov/phdi"
  registry_auth     = data.aws_ecr_authorization_token.this.proxy_endpoint
  registry_username = data.aws_ecr_authorization_token.this.user_name
  registry_password = data.aws_ecr_authorization_token.this.password
  service_data = {
    ecr-viewer = {
      short_name     = "ecrv",
      fargate_cpu    = 1024,
      fargate_memory = 2048,
      min_capacity   = 1
      max_capacity   = 5
      app_image      = var.disable_ecr == false ? "${terraform.workspace}-ecr-viewer" : "ecr-viewer",
      app_version    = var.phdi_version,
      container_port = 3000,
      host_port      = 3000,
      public         = true
      registry_url   = local.registry_url
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
          name  = "NEXT_PUBLIC_NON_INTEGRATED_VIEWER",
          value = var.non_integrated_viewer
        },
        {
          name  = "SOURCE",
          value = "s3"
        },
        {
          name  = "APP_ENV",
          value = var.ecr_viewer_app_env
        },
        {
          name  = "NBS_PUB_KEY",
          value = var.ecr_viewer_auth_pub_key
        },
        {
          name  = "NEXT_PUBLIC_BASEPATH",
          value = var.ecr_viewer_basepath
        }
      ]
    },
    fhir-converter = {
      short_name     = "fhirc",
      fargate_cpu    = 1024,
      fargate_memory = 2048,
      min_capacity   = 1
      max_capacity   = 5
      app_image      = var.disable_ecr == false ? "${terraform.workspace}-fhir-converter" : "fhir-converter",
      app_version    = var.phdi_version,
      container_port = 8080,
      host_port      = 8080,
      public         = false
      registry_url   = local.registry_url
      env_vars       = []
    },
    ingestion = {
      short_name     = "inge",
      fargate_cpu    = 1024,
      fargate_memory = 2048,
      min_capacity   = 1
      max_capacity   = 5
      app_image      = var.disable_ecr == false ? "${terraform.workspace}-ingestion" : "ingestion",
      app_version    = var.phdi_version,
      container_port = 8080,
      host_port      = 8080,
      public         = false
      registry_url   = local.registry_url
      env_vars       = []
    },
    validation = {
      short_name     = "vali",
      fargate_cpu    = 1024,
      fargate_memory = 2048,
      min_capacity   = 1
      max_capacity   = 5
      app_image      = var.disable_ecr == false ? "${terraform.workspace}-validation" : "validation",
      app_version    = var.phdi_version,
      container_port = 8080,
      host_port      = 8080,
      public         = false
      registry_url   = local.registry_url
      env_vars       = []
    },
    trigger-code-reference = {
      short_name     = "trigcr",
      fargate_cpu    = 1024,
      fargate_memory = 2048,
      min_capacity   = 1
      max_capacity   = 5
      app_image      = var.disable_ecr == false ? "${terraform.workspace}-trigger-code-reference" : "trigger-code-reference",
      app_version    = var.phdi_version,
      container_port = 8080,
      host_port      = 8080,
      public         = false
      registry_url   = local.registry_url
      env_vars       = []
    },
    message-parser = {
      short_name     = "msgp",
      fargate_cpu    = 1024,
      fargate_memory = 2048,
      min_capacity   = 1
      max_capacity   = 5
      app_image      = var.disable_ecr == false ? "${terraform.workspace}-message-parser" : "message-parser",
      app_version    = var.phdi_version,
      container_port = 8080,
      host_port      = 8080,
      public         = false
      registry_url   = local.registry_url
      env_vars       = []
    },
    orchestration = {
      short_name     = "orch",
      fargate_cpu    = 1024,
      fargate_memory = 2048,
      min_capacity   = 1
      max_capacity   = 5
      app_image      = var.disable_ecr == false ? "${terraform.workspace}-orchestration" : "orchestration",
      app_version    = var.phdi_version,
      container_port = 8080,
      host_port      = 8080,
      public         = true
      registry_url   = local.registry_url
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
          value = "http://ecr-viewer:3000${var.ecr_viewer_basepath}"
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
  local_name = "${var.project}-${var.owner}-${terraform.workspace}"

  # service_data                 = var.service_data == {} ? local.default_service_data : local.default_service_data
  appmesh_name                 = var.appmesh_name == "" ? local.local_name : var.appmesh_name
  cloudmap_namespace_name      = var.cloudmap_namespace_name == "" ? local.local_name : var.cloudmap_namespace_name
  cloudmap_service_name        = var.cloudmap_service_name == "" ? local.local_name : var.cloudmap_service_name
  ecs_alb_name                 = var.ecs_alb_name == "" ? "${local.local_name}" : var.ecs_alb_name
  ecs_alb_tg_name              = var.ecs_alb_tg_name == "" ? local.local_name : var.ecs_alb_tg_name
  ecs_task_execution_role_name = var.ecs_task_execution_role_name == "" ? "${local.local_name}-tern" : var.ecs_task_execution_role_name
  ecs_task_role_name           = var.ecs_task_role_name == "" ? "${local.local_name}-trn" : var.ecs_task_role_name
  ecs_cloudwatch_group         = var.ecs_cloudwatch_group == "" ? "/${local.local_name}" : var.ecs_cloudwatch_group
  ecs_cluster_name             = var.ecs_cluster_name == "" ? local.local_name : var.ecs_cluster_name
  s3_viewer_bucket_name        = var.s3_viewer_bucket_name == "" ? "${local.local_name}-${random_string.s3_viewer.result}" : var.s3_viewer_bucket_name
  s3_viewer_bucket_role_name   = var.s3_viewer_bucket_role_name == "" ? "${local.local_name}-ecrv" : var.s3_viewer_bucket_role_name
  tags                         = var.tags
  vpc_endpoints = [
    "com.amazonaws.${var.region}.ecr.dkr",
    "com.amazonaws.${var.region}.ecr.api",
    "com.amazonaws.${var.region}.ecs",
    "com.amazonaws.${var.region}.ecs-telemetry",
    "com.amazonaws.${var.region}.logs",
    "com.amazonaws.${var.region}.secretsmanager",
  ]
  s3_service_name    = "com.amazonaws.${var.region}.s3"
  private_subnet_kvs = { for index, rt in var.private_subnet_ids : index => rt }
}
