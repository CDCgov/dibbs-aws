resource "aws_lb" "alb" {
    name                = var.application_load_balancer_name
    load_balancer_type  = "application"
    subnets = [
        #"{aws_default_subnet.}
        #TODO: Look at the Network from our services and see if we can use that here
    
    ]   

    #security_groups     = [aws_security_groups.alb_sg.id]
    security_groups     = []
}

resource "aws_security_group" "alb_sg" {
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # Wide open egress
    # TODO: Determine what is the best egress for Skylight as a template 
    egress {
        from_port   = 80
        to_port     = 80
        protocol    = "-1"
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

resource "aws_lb_target_group" "aws_lb_target_grp" {
    name        = var.target_grp_name
    port        = var.container_port
    protocol    = "HTTP"
    target_type = "ip"
    #vpc_id      = aws_default_vpc.default_vpc.id
}

resource "aws_alb_listener" "listener" {
    load_balancer_arn       = aws_lb.alb.arn
    port                = "80"
    protocol            = "HTTP"
    default_action {
        target_type     = "forward"
        target_grp_arn  = aws_lb_target_group.aws_lb_target_grp.arn
    }
}