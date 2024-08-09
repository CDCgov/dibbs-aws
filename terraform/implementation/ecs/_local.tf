locals {
  ecs_alb_sg = "${var.project}-${var.ecs_alb_sg}-${var.owner}-${terraform.workspace}"
  vpc_name   = "${var.project}-${var.vpc}-${var.owner}-${terraform.workspace}"
}
