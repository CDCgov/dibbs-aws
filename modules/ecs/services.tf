# Note:  The desired_count and launch_type can be changed
resource "aws_ecs_service" "default"{
    name            = "${var.env}-${var.service_name}"
    cluster         = aws_ecs_cluster.ecs_cluster.name  
    launch_type     = var.launch_type.default.type
    #launch_type     = "FARGATE"
    task_definition = aws_ecs_task_definition.default.arn
    desired_count   = var.desired_count

    load_balancer {
        container_name      = "${var.env}-${var.service_name}"
        container_port      = var.container_port
        target_grp_arn      = aws_lb_target_group.aws_lb_target_grp.arn
    }

    depends_on = [aws_alb_listener.listener, aws_iam_role_policy_attachment.ecs-task-execution-role-policy-attachment]

    # TODO: This may not be necessary if our client is handling networking
    #dynamic "network_configuration" {
    #    for_each = var.network_mode == "awsvpc" ? [1] : []
    #    content {
    #        subnets             = data.aws_subnets.subnets.ids
    #        security_groups     = [aws_security_group.security_group.id]
    #        
    #        #Allows network calls inside and outside of AWS
    #        assign_public_ip    = true
    #    }
    #}
}