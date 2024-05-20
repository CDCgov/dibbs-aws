

################################################################################
#### FHIR-CONVERTER-APP (FILTER CONTAINER)
################################################################################

resource "aws_ecs_task_definition" "fhir" {
  family                   = "fhir-converter-task"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  # container_definitions    = data.template_file.fhir_converter_app.rendered

  #TODO: This section is creating the filter or sidecar container
  # However, would like to see the logs in the awslogs driver and fhir-converter service logs
  container_definitions = jsonencode([
    {
      name      = "fhir-converter-filter-container",
      image     = "nginx:latest",
      essential = true,
      portMappings = [
        {
          containerPort = 8080,
          hostPort      = 8080,
          protocol      = "tcp",
        },
      ],
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.ecs_cloudwatch_logs.name,
          "awslogs-region"        = "us-east-1",
          "awslogs-stream-prefix" = "ecs-log-stream",
        },
      },
    },
  ])
  task_role_arn = aws_iam_role.ecs_task_execution_role.arn
}


resource "aws_ecs_service" "fhir_converter_service" {
  name            = "fhir-converter"
  cluster         = aws_ecs_cluster.main.arn
  task_definition = aws_ecs_task_definition.fhir.arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"

  scheduling_strategy = "REPLICA"

  # 50 percent must be healthy during deploys
  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200

  deployment_controller {
    type = "ECS"
  }

  network_configuration {
    security_groups  = [aws_security_group.ecs_tasks.id]
    subnets          = flatten([var.private_subnet_ids])
    assign_public_ip = true
  }

  # load_balancer {
  #   target_group_arn = aws_alb_target_group.main.id
  #   container_name   = "fhir-converter"
  #   container_port   = var.app_port
  # }

  depends_on = [aws_alb_listener.front_end, aws_iam_role_policy_attachment.ecs-task-execution-role-policy-attachment]
}

