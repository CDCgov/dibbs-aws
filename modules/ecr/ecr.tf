resource "aws_ecr_repository" "${local.repo_name}" {
# TODO: Uncomment after reinstalling VSC.  For some reason it deletes code with the $$.  
#resource "aws_ecr_repository""$${local.repo_name}" {
  for_each             = local.images
  name                 = "${local.repo_name}/${local.images}"
  image_tag_mutability = var.repository_image_tag_mutability
  tags                 = merge(local.tags, var.tags)

  # Optionally, you can add more configurations like image scanning
  image_scanning_configuration {
    scan_on_push = true
  }
}

/*resource "aws_ecr_repository" "message_parser_repo" {
  for_each             = local.images
  name                 = "message_parser/ghcr.io/cdcgov/phdi/message-parser:v1.2.11"
  image_tag_mutability = var.repository_image_tag_mutability
  tags                 = merge(local.tags, var.tags)

  # Optionally, you can add more configurations like image scanning
  image_scanning_configuration {
    scan_on_push = true
  }
}*/

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

/*resource "null_resource" "build_and_push_image" {
  provisioner "local-exec" {
    command = <<EOF
      # Build Docker image
      docker build -t my-ecr-repo-image:latest .

      # Login to Amazon ECR using AWS CLI
      #aws ecr get-login-password --region ${var.aws_region} | docker login --username AWS --password-stdin ${aws_ecr_repository.my_repository.repository_url}

      # Tag and push Docker image to Amazon ECR
      docker tag my-ecr-repo-image:latest ${aws_ecr_repository.my_repository.repository_url}:latest
      docker push ${aws_ecr_repository.my_repository.repository_url}:latest
    EOF
  }
}*/
