# Note:  The desired_count and launch_type can be changed
resource "aws_ecs_service" "ecs_service"{
    name            = "${var.env}-${var.service_name}"
    cluster         = aws_ecs_cluster.ecs_cluster.name  
    launch_type     = var.launch_type.type
    task_definition = aws_ecs_task_definition.dibbs_task.arn
    desired_count   = 2

    load_balancer {
        container_name      = "${var.env}-${var.service_name}"
        container_port      = 8080
    }

    # TODO: This may not be necessary if our client is handling networking
    dynamic "network_configuration" {
        for_each = var.network_mode == "awsvpc" ? [1] : []
        content {
            subnets             = data.aws_subnets.subnets.ids
            security_groups     = [aws_security_group.securitygrp.id]
            
            #Allows network calls inside and outside of AWS
            assign_public_ip    = true
        }
    }
}