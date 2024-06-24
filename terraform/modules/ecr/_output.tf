# Note: Values will be sent to the ecs module as a variable through the main.tf file

output "repository_url" {
  value = [for repo in aws_ecr_repository.repo : repo.repository_url]
}
