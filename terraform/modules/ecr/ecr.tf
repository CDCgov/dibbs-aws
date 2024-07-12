# if data.ecr_repository.repository_urls is not defined, then create the repository
resource "aws_ecr_repository" "repository_urls" {
  for_each     = var.service_data
  name         = "${terraform.workspace}-${each.key}"
  force_delete = true
}
