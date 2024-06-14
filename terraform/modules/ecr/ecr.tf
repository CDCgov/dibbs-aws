resource "aws_ecr_repository" "repo" {
  for_each = var.ecr_repos
  name     = each.key
}
