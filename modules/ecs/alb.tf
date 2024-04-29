resource "aws_lb" "alb" {
    name                = var.application_load_balancer_name
    load_balancer_type  = "application"  

    #security_groups     = [aws_security_groups.alb_sg.id]

    subnets             = ["${var.public_subnet_ids[0]}", "${var.public_subnet_ids[1]}"] 
}

resource "aws_security_group" "alb_sg" {
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "0"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # Wide open egress
    # TODO: Determine what is the best egress for Skylight as a template 
    egress {
        from_port   = 80
        to_port     = 80
        protocol    = "0"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "service_security_group" {
    ingress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        security_groups = ["${aws_security_group.alb_sg.id}"]
    }

    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }
}

resource "aws_lb_target_group" "alb_target_grp" {
    name        = var.target_grp_name
    port        = var.container_port
    protocol    = "HTTP"
    #target_type = "ip"
    vpc_id      = var.vpc_id

    health_check {
        path                = "/"
        protocol            = "HTTP"
        timeout             = 5
        interval            = 30
        healthy_threshold   = 2
        unhealthy_threshold = 2
    }
}

resource "aws_alb_listener" "listener" {
    load_balancer_arn   = aws_lb.alb.arn
    port                = var.container_port
    protocol            = "HTTP"
 
    default_action {
        type               = "forward"
        target_group_arn   = aws_lb_target_group.alb_target_grp.arn
    }
}