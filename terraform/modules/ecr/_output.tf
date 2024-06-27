output "repository_url" {
  value = [for repo in aws_ecr_repository.repo : repo.repository_url]
}
