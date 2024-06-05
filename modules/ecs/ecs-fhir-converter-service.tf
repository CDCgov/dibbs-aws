################################################################################
#### FHIR-CONVERTER
################################################################################

resource "aws_ecs_task_definition" "fhir_converter" {
  family                   = "fhir-converter-task"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  container_definitions    = data.template_file.fhir_converter_app.rendered
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn
}

resource "aws_ecs_service" "fhir_converter" {
  name            = "fhir-converter"
  cluster         = aws_ecs_cluster.dibbs_app_cluster.id
  task_definition = aws_ecs_task_definition.fhir_converter.arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"

  # 50 percent must be healthy during deploys
  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200

  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }

  deployment_controller {
    type = "ECS"
  }

  network_configuration {
    security_groups  = ["${aws_security_group.service_security_group.id}"]
    subnets          = var.public_subnet_ids
    assign_public_ip = true
  }

  # aws_alb_listener.listener_80, aws_alb_listener.listener_8080
  depends_on = [aws_iam_role_policy_attachment.ecs-task-execution-role-policy-attachment]
}

# TODO: REFACTOR BY LOOPING THROUGH EACH SERVICE NAME
# resource "aws_ecs_task_definition" "ecs_service_task_definition" {
#   for_each                 = var.ecr_repo_name
#   family                   = "${each.value}-task"
#   execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
#   network_mode             = "awsvpc"
#   requires_compatibilities = ["FARGATE"]
#   cpu                      = var.fargate_cpu
#   memory                   = var.fargate_memory
#   container_definitions    = "{data.template_file}.${each.value}_converter_app.rendered}"
#   task_role_arn            = aws_iam_role.ecs_task_execution_role.arn
# }

# resource "aws_ecs_service" "ecs_service" {
#   # name            = "fhir-converter"
#   for_each        = var.ecr_repo_name
#   name            = each.value
#   cluster         = aws_ecs_cluster.dibbs_app_cluster.id
#   task_definition = aws_ecs_task_definition.ecs_service_task_definition.arn
#   desired_count   = var.app_count
#   launch_type     = "FARGATE"

#   # 50 percent must be healthy during deploys
#   deployment_minimum_healthy_percent = 50
#   deployment_maximum_percent         = 200

#   deployment_circuit_breaker {
#     enable   = true
#     rollback = true
#   }

#   deployment_controller {
#     type = "ECS"
#   }

#   network_configuration {
#     security_groups  = ["${aws_security_group.service_security_group.id}"]
#     subnets          = var.public_subnet_ids
#     assign_public_ip = true
#   }

#   # aws_alb_listener.listener_80, aws_alb_listener.listener_8080
#   depends_on = [aws_alb_listener.listener_80, aws_alb_listener.listener_8080, aws_iam_role_policy_attachment.ecs-task-execution-role-policy-attachment]
# }
