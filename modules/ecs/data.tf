##############################################
####### DATA IAM PERMISSIONS FOR ECS TO ######
############# INTERACT WITH ECR ##############
##############################################

data "aws_iam_policy_document" "ecr_and_ecs_permissions_policy_document" {
  statement {
    actions   = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage"
    ]
    resources = [
        "arn:aws:ecs:us-east-1:339712971032:cluster/dibbs-ecs-cluster",
        "arn:aws:ecs:us-east-1:339712971032:cluster/dibbs-ecs-cluster/*"
    ]
  }
}

##############################################
### DATA IAM PERMISSIONS FOR ECS TASKS #######
##############################################

data "aws_iam_policy_document" "ecs_task_assume_role_policy" { 
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

##########################
#### DATA TEMPLATES ######
##########################

data "template_file" "fhir_converter_app" {
    template = file("./modules/templates/ecs/fhir_converter_app.json.tpl")

    vars = {
        app_image      = var.app_image
        app_port       = var.app_port
        fargate_cpu    = var.fargate_cpu
        fargate_memory = var.fargate_memory
        #aws_region     = var.aws_region
        #aws_cloudwatch_log_group = var.aws_cloudwatch_log_group
    }
}

data "template_file" "ingestion_app" {
    template = file("./modules/templates/ecs/ingestion_app.json.tpl")

    vars = {
        app_image      = var.app_image
        app_port       = var.app_port
        fargate_cpu    = var.fargate_cpu
        fargate_memory = var.fargate_memory
        #aws_region     = var.aws_region
    }
}

data "template_file" "ingress_app" {
    template = file("./modules/templates/ecs/ingress_app.json.tpl")

    vars = {
        app_image      = var.app_image
        app_port       = var.app_port
        fargate_cpu    = var.fargate_cpu
        fargate_memory = var.fargate_memory
        #aws_region     = var.aws_region
    }
}

data "template_file" "message_parser_app" {
    template = file("./modules/templates/ecs/message_parser_app.json.tpl")

    vars = {
        app_image      = var.app_image
        app_port       = var.app_port
        fargate_cpu    = var.fargate_cpu
        fargate_memory = var.fargate_memory
    }
}

data "template_file" "orchestration_app" {
    template = file("./modules/templates/ecs/orchestration_app.json.tpl")

    vars = {
        app_image      = var.app_image
        app_port       = var.app_port
        fargate_cpu    = var.fargate_cpu
        fargate_memory = var.fargate_memory
        #aws_region     = var.aws_region
    }
}
