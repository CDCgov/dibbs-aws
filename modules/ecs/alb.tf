resource "aws_alb" "main" {
  name               = var.application_load_balancer_name
  internal           = false
  load_balancer_type = "application"
  subnets            = flatten([var.public_subnet_ids])
  security_groups    = [aws_security_group.alb_sg.id]

  enable_deletion_protection = false

  tags = {
    Name = "dibbs-ecs-alb"
  }
}

resource "aws_alb_target_group" "main" {
  name        = "dibbs-ecs-alb-target-group"
  port        = var.app_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = var.health_check_path
    unhealthy_threshold = "2"
  }
}

# Redirect all traffic from the ALB to the target group
resource "aws_alb_listener" "listener" {
  load_balancer_arn = aws_alb.main.arn
  port              = var.app_port
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.main.arn
    type             = "forward"
  }
}
