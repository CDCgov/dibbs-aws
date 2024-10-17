resource "aws_ecs_cluster" "dibbs_app_cluster" {
  name = local.ecs_cluster_name
  tags = local.tags
}

resource "aws_ecs_task_definition" "this" {
  for_each                 = local.service_data
  family                   = each.key
  execution_role_arn       = aws_iam_role.ecs_task_execution.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = each.value.fargate_cpu
  memory                   = each.value.fargate_memory
  container_definitions = jsonencode([
    {
      name        = each.key,
      image       = var.disable_ecr == false ? dockerless_remote_image.dibbs[each.key].target : "${each.value.registry_url}/${each.value.app_image}:${each.value.app_version}",
      networkMode = "awsvpc",
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          awslogs-group         = local.ecs_cloudwatch_group,
          awslogs-region        = var.region,
          awslogs-stream-prefix = "ecs"
        }
      },
      portMappings = [
        {
          containerPort = each.value.container_port,
          hostPort      = each.value.host_port,
          name          = "http"
        }
      ],
      environment = each.value.env_vars,
    }
  ])
  task_role_arn = each.key == "ecr-viewer" ? aws_iam_role.s3_role_for_ecr_viewer.arn : aws_iam_role.ecs_task.arn
  tags          = local.tags
}

resource "aws_ecs_service" "this" {
  for_each        = aws_ecs_task_definition.this
  name            = each.key
  cluster         = aws_ecs_cluster.dibbs_app_cluster.id
  task_definition = each.value.arn
  desired_count   = local.service_data[each.key].min_capacity
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
    # and local.service_data so that we only create a dynamic load_balancer block for the public services.
    # It may seem a little weird but it works and I'm happy with it.
    # We loop through the service_data so that we have access to the container_port
    for_each = {
      for key, value in local.service_data : key => value
      if local.service_data[key].public == true && each.key == key
    }
    content {
      target_group_arn = aws_alb_target_group.this[each.key].arn
      container_name   = each.key
      container_port   = local.service_data[each.key].container_port
    }
  }

  network_configuration {
    security_groups  = [aws_security_group.ecs.id]
    subnets          = var.private_subnet_ids
    assign_public_ip = false
  }

  service_connect_configuration {
    enabled   = "true"
    namespace = aws_service_discovery_private_dns_namespace.this.arn
    log_configuration {
      log_driver = "awslogs"
      options = {
        "awslogs-group"         = local.ecs_cloudwatch_group
        "awslogs-region"        = var.region
        "awslogs-stream-prefix" = "ecs"
      }
    }
    service {
      discovery_name = each.key
      port_name      = "http"
      client_alias {
        dns_name = each.key
        port     = local.service_data[each.key].container_port
      }
    }
  }

  lifecycle {
    ignore_changes = [desired_count]
  }

  tags = local.tags
}
