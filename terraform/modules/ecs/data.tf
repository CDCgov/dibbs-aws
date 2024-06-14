##########################
#### DATA TEMPLATES ######
##########################

data "template_file" "fhir_converter_app" {
  template = file("../../modules/ecs/templates/app.json.tpl")
  vars = {
    name                    = "fhir-converter"
    app_image                = var.app_image
    app_port                 = var.app_port
    region                   = var.region
    fargate_cpu              = var.fargate_cpu
    fargate_memory           = var.fargate_memory
    aws_cloudwatch_log_group = var.aws_cloudwatch_log_group
  }
}

data "template_file" "ingestion_app" {
  template = file("../../modules/ecs/templates/app.json.tpl")

  vars = {
    name                    = "ingestion"
    app_image                = var.app_image
    app_port                 = var.app_port
    region                   = var.region
    fargate_cpu              = var.fargate_cpu
    fargate_memory           = var.fargate_memory
    aws_cloudwatch_log_group = var.aws_cloudwatch_log_group
  }
}

data "template_file" "validation_app" {
  template = file("../../modules/ecs/templates/app.json.tpl")

  vars = {
    name                    = "validation"    
    app_image                = var.app_image
    app_port                 = var.app_port
    region                   = var.region
    fargate_cpu              = var.fargate_cpu
    fargate_memory           = var.fargate_memory
    aws_cloudwatch_log_group = var.aws_cloudwatch_log_group
  }
}

data "template_file" "orchestration_app" {
  template = file("../../modules/ecs/templates/orchestration_app.json.tpl")

  vars = {
    name                    = "orchestration"
    app_image                = var.app_image
    app_port                 = var.app_port
    region                   = var.region
    fargate_cpu              = var.fargate_cpu
    fargate_memory           = var.fargate_memory
    aws_cloudwatch_log_group = var.aws_cloudwatch_log_group
  }
}

data "template_file" "ecr_viewer_app" {
  template = file("../../modules/ecs/templates/app.json.tpl")

  vars = {
    name                    = "ecr-viewer"
    app_image                = var.app_image
    app_port                 = var.app_port
    region                   = var.region
    fargate_cpu              = var.fargate_cpu
    fargate_memory           = var.fargate_memory
    aws_cloudwatch_log_group = var.aws_cloudwatch_log_group
  }
}
