resource "aws_ecr_repository" "repo" {
  for_each = var.service_data
  name     = each.key
  force_delete = true
}
