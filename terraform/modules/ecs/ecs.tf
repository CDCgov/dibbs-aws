resource "aws_ecs_cluster" "dibbs_app_cluster" {
  name = var.ecs_cluster_name
}

resource "aws_ecs_task_definition" "this" {
  for_each                 = var.service_data
  family                   = each.key
  execution_role_arn       = var.ecs_task_execution_role_arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = each.value.fargate_cpu
  memory                   = each.value.fargate_memory
  container_definitions = jsonencode([
    {
      name        = each.key,
      image       = each.value.app_image,
      networkMode = "awsvpc",
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          awslogs-group         = var.ecs_cloudwatch_log_group,
          awslogs-region        = var.region,
          awslogs-stream-prefix = "ecs"
        }
      },
      portMappings = [
        {
          containerPort = each.value.container_port,
          hostPort      = each.value.host_port
        }
      ],
      environment = each.value.env_vars
    }
  ])
  task_role_arn = var.ecs_task_execution_role_arn
}

resource "aws_ecs_service" "this" {
  for_each        = aws_ecs_task_definition.this
  name            = each.key
  cluster         = aws_ecs_cluster.dibbs_app_cluster.id
  task_definition = each.value.arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"

  scheduling_strategy = "REPLICA"

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

  dynamic "load_balancer" {
    for_each = {
      for key, value in var.service_data : key => value
      if(each.key == "orchestration" && key == "orchestration") || (each.key == "ecr-viewer" && key == "ecr-viewer")
    }
    content {
      target_group_arn = aws_alb_target_group.this.arn
      container_name   = load_balancer.key
      container_port   = load_balancer.value.container_port
    }
  }

  network_configuration {
    security_groups  = [aws_security_group.ecs.id]
    subnets          = var.private_subnet_ids
    assign_public_ip = false
  }

  service_registries {
    registry_arn = aws_service_discovery_service.this.arn
  }
}