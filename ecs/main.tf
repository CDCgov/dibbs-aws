resource "aws_ecs_cluster" "ecs_cluster" {
 name = "dibbs-ecs-cluster"
}

resource "aws_ecs_service" "ecs_service"{
    name            = var.service_name
    cluster         = aws_ecs_cluster.cluster.name  
    launch_type     = var.launch_type.type
    task_definition = aws_ecs_task_definition.task.arn
    desired_count   = 2

    load_balancer {
        container_name      = local.container_name
        container_port      = local.container_port
        target_group_arn    = var.target_group_arn
    }

    dynmaic "network_configuration" {
        for_each = var.network_mode == "awsvpc" ? [1] : []
        content {
            suwbnets             = data.aws_subnets.subnets.ids
            security_groups     = [aws_security_group.securitygrp.id]
            #Allows network calls inside and outside of AWS
            assigned_public_ip  = true
        }
    }
}

resource "aws_ecs_task_definition" "task" {
    family                  = var.task_family
    network_mode            = var.network_mode
    requires_compatibilities = [var.launch_type.type]
    execution_role_arn      = aws_iam_role.task_role.arn
    container_definitions   = local.container_definitions
    cpu                     = var.launch_type.cpu
    memory                  = var.launch_type.memory
}