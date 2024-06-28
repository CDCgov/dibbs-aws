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
      image       = "${each.value.app_image}:${each.value.app_version}",
      networkMode = "awsvpc",
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          awslogs-group         = var.ecs_cloudwatch_group,
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
  desired_count   = var.service_data[each.key].app_count
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

  force_new_deployment = true
  triggers = {
    redeployment = plantimestamp()
  }

  dynamic "load_balancer" {
    # The conditional for this for_each checks the key for the current interation of aws_ecs_task_definition.this
    # and var.service_data so that we only create a dynamic load_balancer block for the public services.
    # It may seem a little weird but it works and I'm happy with it.
    # We loop through the service_data so that we have access to the container_port
    # TODO: set a local.public_services list variable that only contains the public services
    for_each = {
      for key, value in var.service_data : key => value
      if(each.key == "orchestration" && key == "orchestration") || (each.key == "ecr-viewer" && key == "ecr-viewer")
    }
    content {
      target_group_arn = aws_alb_target_group.this[each.key].arn
      container_name   = each.key
      container_port   = var.service_data[each.key].container_port
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