################################################################################
#### FHIR-CONVERTER-APP (FILTER CONTAINER)
################################################################################

resource "aws_ecs_task_definition" "fhir_converter" {
  family                   = "fhir-converter"
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
  desired_count   = 1
  launch_type     = "FARGATE"

  #force_new_deployment = true

  #scheduling_strategy = "REPLICA"

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

  # load_balancer {
  #   target_group_arn = aws_alb_target_group.main.arn
  #   container_name   = aws_ecs_task_definition.fhir_converter.family
  #   container_port   = var.app_port
  # }

  network_configuration {
    security_groups  = ["${aws_security_group.service_security_group.id}"]
    subnets          = flatten([var.public_subnet_ids])
    assign_public_ip = true
  }

  # aws_alb_listener.listener
  depends_on = [aws_iam_role_policy_attachment.ecs-task-execution-role-policy-attachment]
}

resource "aws_subnet_association" "aws_sub_assoc" {
  subnet_id = flatten([var.public_subnet_ids])
  vpc_id    = var.vpc_id.id
}
