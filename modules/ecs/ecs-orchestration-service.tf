################################################################################
#### ORCHESTRATION SERVICE
################################################################################

resource "aws_ecs_task_definition" "orchestration" {
  family                   = "orchestration-task"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  container_definitions    = data.template_file.orchestration_app.rendered
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn
}

resource "aws_ecs_service" "orchestration" {
  name            = "orchestration"
  cluster         = aws_ecs_cluster.dibbs_app_cluster.id
  task_definition = aws_ecs_task_definition.orchestration.arn
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
    security_groups  = ["${aws_security_group.service_security_group.id}", "${aws_security_group.orchestration_sg.id}"]
    subnets          = var.public_subnet_ids
    assign_public_ip = true
  }
  service_registries {
    registry_arn = aws_service_discovery_service.orchestration_service.arn
  }

  # aws_alb_listener.listener_80, aws_alb_listener.listener_8080
  # depends_on = [aws_iam_role_policy_attachment.ecs_task_execution_role-policy_attachment]
  depends_on = [aws_iam_role_policy_attachment.ecs_task_execution_role_policy_secondary_attachment]

}
