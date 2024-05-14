# Note: This value will be sent to the ecs module as a variable through the main.tf file
output "repository_urls" {
  value = { for key, repo in aws_ecr_repository.repo : key => repo.repository_url }
}
