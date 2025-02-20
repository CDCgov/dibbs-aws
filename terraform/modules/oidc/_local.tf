locals {
  github_role_name = "${var.project}-github-role-${var.owner}-${var.workspace}-${random_string.oidc.result}"
  wildcard         = "*"
  vpc_id           = var.vpc_id == "" ? local.wildcard : var.vpc_id
}