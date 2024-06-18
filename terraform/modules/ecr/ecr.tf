resource "aws_ecr_repository" "repo" {
  for_each = var.ecr_repo_names
  name     = each.key
}
