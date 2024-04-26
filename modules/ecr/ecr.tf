resource "aws_ecr_repository" "repo" {
  name                  = var.ecr_repo_name 
  image_tag_mutability  = var.repository_image_tag_mutability
  tags                  = merge(local.tags, var.tags)
  
  # Optionally, you can add more configurations like image scanning
  image_scanning_configuration {
    scan_on_push = true
  }
}

data "aws_caller_identity" "current" {}

data "aws_regions" "regions" {}

resource "aws_ecr_replication_configuration" "dibbs_ecr_replication_config" {
    count = var.create && var.create_registry_replication_configuration ? 1 : 0

    replication_configuration {

    dynamic "rule" {
      for_each = var.registry_replication_rules

      content {
        dynamic "destination" {
          for_each = rule.value.destinations

          content {
            region      = destination.value.region
            registry_id = destination.value.registry_id
          }
        }

        dynamic "repository_filter" {
          for_each = try(rule.value.repository_filters, [])

          content {
            filter      = repository_filter.value.filter
            filter_type = repository_filter.value.filter_type
          }
        }
      }
    }
  }
}

resource "aws_ecr_lifecycle_policy" "main" {
  repository = aws_ecr_repository.repo.name
  policy     = local.policy
}

# Only create the resource if policy is specified. By Default AWS does not
# attach a ECR policy to a repository.
resource "aws_ecr_repository_policy" "main" {
  repository = aws_ecr_repository.repo.name
  policy     = var.ecr_policy
  count      = length(var.ecr_policy) > 0 ? 1 : 0
}