# Note:  The desired_count and launch_type can be changed
resource "aws_ecs_service" "default"{
    name            = "${var.service_name}-${var.env}"
    cluster         = aws_ecs_cluster.ecs_cluster.name  
    #launch_type     = var.launch_type.type
    launch_type     = "FARGATE"
    task_definition = aws_ecs_task_definition.default_app_task.arn
    desired_count   = var.desired_count

    load_balancer {
        container_name      = aws_ecs_task_definition.default_app_task.family
        container_port      = var.container_port
        target_group_arn    = aws_lb_target_group.alb_target_grp.arn
    }

    #depends_on = [aws_lb_target_group.alb_target_grp, aws_iam_role_policy_attachment.ecs-task-execution-role-policy-attachment]

    # TODO: This may not be necessary if our client is handling networking
    network_configuration {
        subnets          = ["${aws_default_subnet.default_subnet_a.id}", "${aws_default_subnet.default_subnet_b.id}", "${aws_default_subnet.default_subnet_c.id}"]
        assign_public_ip = true
        security_groups  = ["${aws_security_group.ecs_task_sg.id}"]
    }
}