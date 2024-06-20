resource "aws_alb" "main" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  subnets            = flatten([var.public_subnet_ids])
  security_groups    = [aws_security_group.alb.id]

  enable_deletion_protection = false

  tags = {
    Name = var.alb_name
  }
}

# Defines the target gropu associated with the ALB
resource "aws_alb_target_group" "this" {
  for_each = {
    for key, value in var.service_data : key => value
    if(key == "orchestration") || (key == "ecr-viewer")
  }
  name        = "${each.key}-tg"
  port        = each.value.container_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    healthy_threshold   = "3"
    interval            = "120"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = var.health_check_path
    unhealthy_threshold = "2"
  }
}

# The aws_alb_listener and aws_alb_listener_rule resources are depended on by other resources so
# they can be implemented via a loop or hard coded depending ease of maintenance
# I've chosen the ways that reduce duplicated resource blocks: hard code the listener, loop for listener rule

# We may want to create this resource via a loop through our target groups but at the moment that seemed extra
resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_alb.main.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.this["ecr-viewer"].arn
  }
}

# We may wan to create this resource without the loop if the path_patterns ever break the pattern of being the name of the service
resource "aws_alb_listener_rule" "this" {
  for_each = {
    for key, value in aws_alb_target_group.this : key => value
    if(key == "orchestration") || (key == "ecr-viewer")
  }
  listener_arn = aws_alb_listener.http.arn

  action {
    type             = "forward"
    target_group_arn = each.value.arn
  }

  condition {
    path_pattern {
      values = ["/${each.key}/*"]
    }
  }

}

# Security Group for ECS
resource "aws_security_group" "ecs" {
  vpc_id                 = var.vpc_id
  name                   = "dibbs-aws-ecs"
  description            = "Security group for ECS"
  revoke_rules_on_delete = true
  lifecycle {
    create_before_destroy = true
  }
}

# ECS Security Group Rules - INBOUND
resource "aws_security_group_rule" "ecs_alb_ingress" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  description              = "Allow inbound traffic from ALB"
  security_group_id        = aws_security_group.ecs.id
  source_security_group_id = aws_security_group.alb.id
}

# ECS Security Group Rules - OUTBOUND
resource "aws_security_group_rule" "ecs_all_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  description       = "Allow outbound traffic from ECS"
  security_group_id = aws_security_group.ecs.id
  cidr_blocks       = ["0.0.0.0/0"]
}

# Security Group for alb
resource "aws_security_group" "alb" {
  vpc_id                 = var.vpc_id
  name                   = "dibbs-aws-ecs-alb"
  description            = "Security group for ALB"
  revoke_rules_on_delete = true
  lifecycle {
    create_before_destroy = true
  }
}

# Alb Security Group Rules - INBOUND
resource "aws_security_group_rule" "alb_http_ingress" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "TCP"
  description       = "Allow http inbound traffic from internet"
  security_group_id = aws_security_group.alb.id
  cidr_blocks       = ["0.0.0.0/0"]
}

# Alb Security Group Rules - INBOUND
resource "aws_security_group_rule" "alb_https_ingress" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "TCP"
  description       = "Allow https inbound traffic from internet"
  security_group_id = aws_security_group.alb.id
  cidr_blocks       = ["0.0.0.0/0"]
}

# Alb Security Group Rules - OUTBOUND
resource "aws_security_group_rule" "alb_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  description       = "Allow outbound traffic from alb"
  security_group_id = aws_security_group.alb.id
  cidr_blocks       = ["0.0.0.0/0"]
}