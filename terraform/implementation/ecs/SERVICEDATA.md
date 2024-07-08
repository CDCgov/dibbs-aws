# Integrated ecr-viewer

```hcl
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
        name = "OTEL_METRICS",
        value = "none"
      },
      {
        name = "OTEL_METRICS_EXPORTER",
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
        value = "http://ecr-viewer:3000"
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
```