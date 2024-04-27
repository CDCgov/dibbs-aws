data "aws_ecr_repository" "default" {
  name = var.ecr_repo_name
}