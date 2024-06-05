# ALB security Group: Edit to restrict access to the application
resource "aws_security_group" "alb_sg" {
  name        = "dibbs-aws-ecs-alb-security-group"
  description = "controls access to the ALB"
  vpc_id      = var.vpc_id

  ingress {
    protocol    = "tcp"
    from_port   = var.app_port
    to_port     = var.app_port
    cidr_blocks = ["0.0.0.0/0"]
  }
  #matches the load balancer listener rule (without unreachable)
  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "tcp"
    from_port   = 8080 #changed from https port 443
    to_port     = 8080 #changed from https port 443
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "orchestration_sg" {
  name        = "dibbs-aws-ecs-orchestration-security-group"
  description = "controls access to the orchestration service"
  vpc_id      = var.vpc_id


  #matches the load balancer listener rule (without unreachable)
  ingress {
    protocol    = "tcp"
    from_port   = var.app_port
    to_port     = var.app_port
    cidr_blocks = ["${var.cidr}"]
  }
  #matches the load balancer listener rule (without unreachable)
  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["${var.cidr}"]
  }

  egress {
    protocol    = "tcp"
    from_port   = 8080
    to_port     = 8080
    cidr_blocks = ["${var.cidr}"]
  }
}
