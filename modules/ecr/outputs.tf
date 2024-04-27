# Note: This value will be sent to the ecs module as a variable through the main.tf file
output "repository_url" {
    value = aws_ecr_repository.repo.repository_url
}

