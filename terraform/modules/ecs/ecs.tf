resource "aws_ecs_cluster" "dibbs_app_cluster" {
  name = var.ecs_cluster_name
}

resource "aws_default_vpc" "default_vpc" {}

resource "aws_default_subnet" "default_subnet_a" {
  availability_zone = var.availability_zones[0]
}

resource "aws_default_subnet" "default_subnet_b" {
  availability_zone = var.availability_zones[1]
}

resource "aws_security_group" "load_balancer_security_group" {
  vpc_id = var.vpc_id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# resource "aws_lb_target_group" "target_group" {
#   name        = var.target_group_name
#   port        = var.container_port
#   protocol    = "HTTP"
#   target_type = "ip"
#   vpc_id      = var.vpc_id
# }

# resource "aws_lb_listener" "listener" {
#   load_balancer_arn = aws_alb.main.arn
#   port              = "80"
#   protocol          = "HTTP"
#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.target_group.arn
#   }
# }

resource "aws_security_group" "service_security_group" {
  vpc_id = var.vpc_id
  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = ["${aws_security_group.load_balancer_security_group.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_ecs_task_definition" "this" {
    for_each = local.services
  family                   = "${each.key}"
  execution_role_arn       = var.ecs_task_execution_role_arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = each.value.fargate_cpu
  memory                   = each.value.fargate_memory
    container_definitions    = jsonencode([
    {
    name = "${each.key}-app",
    image = "${each.value.app_image}",
    networkMode = "awsvpc",
    logConfiguration = {
        logDriver = "awslogs",
        options = {
          awslogs-group = "${var.ecs_cloudwatch_log_group}",
          awslogs-region = "${var.region}",
          awslogs-stream-prefix = "ecs"
        }
    },
    portMappings = [
      {
        containerPort = each.value.container_port,
        hostPort = each.value.host_port
      }
    ],
    environment = each.value.env_vars
    }
  ])
  task_role_arn            = var.ecs_task_execution_role_arn
}

resource "aws_ecs_service" "this" {
    for_each = aws_ecs_task_definition.this
  name            = "${each.key}"
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

  network_configuration {
    security_groups  = ["${aws_security_group.service_security_group.id}"]
    subnets          = var.public_subnet_ids
    assign_public_ip = true
  }

  service_registries {
    registry_arn = aws_service_discovery_service.this.arn
  }
}