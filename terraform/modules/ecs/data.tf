##########################
#### DATA TEMPLATES ######
##########################

data "template_file" "fhir_converter_app" {
  template = file("../../modules/ecs/templates/fhir_converter_app.json.tpl")
  vars = {
    app_image                = var.app_image
    app_port                 = var.app_port
    fargate_cpu              = var.fargate_cpu
    fargate_memory           = var.fargate_memory
    aws_region               = var.aws_region
    aws_cloudwatch_log_group = var.aws_cloudwatch_log_group
  }
}

data "template_file" "ingestion_app" {
  template = file("../../modules/ecs/templates/ingestion_app.json.tpl")

  vars = {
    app_image      = var.app_image
    app_port       = var.app_port
    fargate_cpu    = var.fargate_cpu
    fargate_memory = var.fargate_memory
    #aws_region     = var.aws_region
  }
}

data "template_file" "validation_app" {
  template = file("../../modules/ecs/templates/validation_app.json.tpl")

  vars = {
    app_image      = var.app_image
    app_port       = var.app_port
    fargate_cpu    = var.fargate_cpu
    fargate_memory = var.fargate_memory
    #aws_region     = var.aws_region
  }
}

data "template_file" "orchestration_app" {
  template = file("../../modules/ecs/templates/orchestration_app.json.tpl")

  vars = {
    app_image      = var.app_image
    app_port       = var.app_port
    fargate_cpu    = var.fargate_cpu
    fargate_memory = var.fargate_memory
  }
}

data "template_file" "ecr_viewer_app" {
  template = file("../../modules/ecs/templates/ecr_viewer_app.json.tpl")

  vars = {
    app_image      = var.app_image
    app_port       = var.app_port
    fargate_cpu    = var.fargate_cpu
    fargate_memory = var.fargate_memory
    #aws_region     = var.aws_region
  }
}
