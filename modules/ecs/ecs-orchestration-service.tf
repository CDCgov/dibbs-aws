################################################################################
#### ORCHESTRATION SERVICE
################################################################################

resource "aws_ecs_task_definition" "orchestration" {
    family                   = "orchestration-app-task"
    execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
    network_mode             = "awsvpc"
    requires_compatibilities = ["FARGATE"]
    cpu                      = var.fargate_cpu
    memory                   = var.fargate_memory
    container_definitions    = data.template_file.orchestration_app.rendered
}

resource "aws_ecs_service" "orchestration" {
    name            = "orchestration-service"
    cluster         = aws_ecs_cluster.main.id
    task_definition = aws_ecs_task_definition.orchestration.arn
    desired_count   = var.app_count
    launch_type     = "FARGATE"
    
    scheduling_strategy = "REPLICA"

    # 50 percent must be healthy during deploys
    deployment_minimum_healthy_percent = 50
    deployment_maximum_percent         = 100

    network_configuration {
        security_groups  = [aws_security_group.ecs_tasks.id]
        subnets          = aws_subnet.private.*.id
        assign_public_ip = true
    }

    load_balancer {
        target_group_arn = aws_alb_target_group.main.id
        container_name   = "orchestration-app"
        container_port   = var.app_port
    }

    depends_on = [aws_alb_listener.front_end, aws_iam_role_policy_attachment.ecs-task-execution-role-policy-attachment]
}