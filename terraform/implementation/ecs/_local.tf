locals {
  vpc_name = "${var.project}-${var.owner}-${terraform.workspace}"
  tags = {
    owner       = var.owner
    workspace   = terraform.workspace
    project     = var.project
    environment = terraform.workspace
  }
}
