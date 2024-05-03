data "aws_iam_policy_document" "ecs_task_assume_role_policy" { 
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

# Create a data source to pull the latest active revision from
/*data "aws_ecs_task_definition" "app" {
  task_definition = aws_ecs_task_definition.app.family
  depends_on      = [aws_ecs_task_definition.app] # ensures at least one task def exists
}*/

data "template_file" "cb_app" {
    template = file("./templates/ecs/cb_app.json.tpl")

    vars = {
        app_image      = var.app_image
        app_port       = var.app_port
        fargate_cpu    = var.fargate_cpu
        fargate_memory = var.fargate_memory
        #aws_region     = var.aws_region
    }
}

data "template_file" "fhir_converter_app" {
    template = file("./templates/ecs/fhir_converter_app.json.tpl")

    vars = {
        app_image      = var.app_image
        app_port       = var.app_port
        fargate_cpu    = var.fargate_cpu
        fargate_memory = var.fargate_memory
        #aws_region     = var.aws_region
    }
}

data "template_file" "ingestion_app" {
    template = file("./templates/ecs/ingestion_app.json.tpl")

    vars = {
        app_image      = var.app_image
        app_port       = var.app_port
        fargate_cpu    = var.fargate_cpu
        fargate_memory = var.fargate_memory
        #aws_region     = var.aws_region
    }
}

data "template_file" "message_parser_app" {
    template = file("./templates/ecs/message_parser_app.json.tpl")

    vars = {
        app_image      = var.app_image
        app_port       = var.app_port
        fargate_cpu    = var.fargate_cpu
        fargate_memory = var.fargate_memory
    }
}

data "template_file" "orchestration_app" {
    template = file("./templates/ecs/orchestration_app.json.tpl")

    vars = {
        app_image      = var.app_image
        app_port       = var.app_port
        fargate_cpu    = var.fargate_cpu
        fargate_memory = var.fargate_memory
        #aws_region     = var.aws_region
    }
}
