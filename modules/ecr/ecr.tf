#resource "aws_ecr_repository" "${local.repo_name}" {
# TODO: Uncomment after reinstalling VSC.  For some reason it deletes code with the $$.  
#resource "aws_ecr_repository" "${local.repo_name}"{
# resource "aws_ecr_repository" "repo" {
#   for_each             = var.ecr_repo_name
#   name                 = each.key
#   image_tag_mutability = var.repository_image_tag_mutability
#   tags                 = merge(local.tags, var.tags)

#   # Optionally, you can add more configurations like image scanning
#   image_scanning_configuration {
#     scan_on_push = true
#   }
# }

# resource "aws_ecr_replication_configuration" "dibbs_ecr_replication_config" {
#   count = var.create && var.create_registry_replication_configuration ? 1 : 0

#   replication_configuration {

#     dynamic "rule" {
#       for_each = var.registry_replication_rules

#       content {
#         dynamic "destination" {
#           for_each = rule.value.destinations

#           content {
#             region      = destination.value.region
#             registry_id = destination.value.registry_id
#           }
#         }

#         dynamic "repository_filter" {
#           for_each = try(rule.value.repository_filters, [])

#           content {
#             filter      = repository_filter.value.filter
#             filter_type = repository_filter.value.filter_type
#           }
#         }
#       }
#     }
#   }
# }

# resource "aws_ecr_lifecycle_policy" "main" {
#   for_each   = var.ecr_repo_name
#   repository = aws_ecr_repository.repo[each.key].name
#   policy     = local.policy
# }

# # Only create the resource if policy is specified. By Default AWS does not
# # attach a ECR policy to a repository.
# /*resource "aws_ecr_repository_policy" "main" {
#   for_each   = var.ecr_repo_name
#   repository = "${aws_ecr_repository.repo[each.key].name}-repo"
#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Sid       = "AllowPullAccess"
#         Effect    = "Allow",
#         Principal = "*",
#         Action    = "ecr:*"
#       },
#     ]
#   })
# }*/




# /*resource "null_resource" "build_and_push_image" {
#   provisioner "local-exec" {
#     command = <<EOF
#       # Build Docker image
#       docker build -t my-ecr-repo-image:latest .

#       # Login to Amazon ECR using AWS CLI
#       #aws ecr get-login-password --region ${var.aws_region} | docker login --username AWS --password-stdin ${aws_ecr_repository.my_repository.repository_url}

#       # Tag and push Docker image to Amazon ECR
#       docker tag my-ecr-repo-image:latest ${aws_ecr_repository.my_repository.repository_url}:latest
#       docker push ${aws_ecr_repository.my_repository.repository_url}:latest
#     EOF
#   }
# }*/

resource "aws_ecr_repository" "repo" {
  for_each = var.ecr_repo_name
  name     = each.key
}
