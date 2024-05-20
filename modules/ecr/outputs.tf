# Note: This value will be sent to the ecs module as a variable through the main.tf file
output "repository_urls" {
  value = { for key, repo in aws_ecr_repository.repo : key => repo.repository_url }
}

# output "ecr_repo_name" {
#   value = { for key, name in var.ecr_repo_name : key => name.var.ecr_repo_name }
# }
