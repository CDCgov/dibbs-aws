# ALB security Group: Edit to restrict access to the application
resource "aws_security_group" "alb_sg" {
  name        = "dibbs-aws-ecs-alb-security-group"
  description = "controls access to the ALB"
  vpc_id      = var.vpc_id

  ingress {
    protocol    = "tcp"
    from_port   = var.app_port
    to_port     = var.app_port
    cidr_blocks = ["${var.cidr}"]
  }

  egress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["${var.cidr}"]
  }
}

# Traffic to the ECS cluster should only come from the ALB
# resource "aws_security_group" "service_security_group" {
#   name        = "dibbs-aws-ecs-tasks-security-group"
#   description = "allow inbound access from the ALB only"
#   vpc_id      = var.vpc_id

#   ingress {
#     # protocol = "tcp"
#     # from_port = var.app_port
#     # to_port   = var.app_port
#     from_port = 0
#     to_port   = 0
#     protocol  = "-1"
#     # cidr_blocks     = ["${var.cidr}"]
#     security_groups = [aws_security_group.alb_sg.id]
#   }

#   egress {
#     protocol    = "-1"
#     from_port   = 0
#     to_port     = 0
#     cidr_blocks = ["${var.cidr}"]
#   }
# }
