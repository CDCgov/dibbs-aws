# resource "aws_iam_policy" "ecr_policy" {
#   for_each    = var.ecr_repo_name
#   name        = "ecr-access-policy-${each.key}"
#   description = "Allow ECS tasks to access ECR"
#   policy      = data.aws_iam_policy_document.ecr_policy[each.key].json

#   depends_on = [aws_ecr_repository.repo]
# }

# Ensure that the IAM policy is created after the ECR repository
# You can also use depends_on with aws_ecr_repository.my_repository as well
# resource "aws_iam_policy_attachment" "attachment" {
#   for_each   = aws_iam_policy.ecr_policy
#   name       = "ecr-policy-attachment-${each.key}"
#   policy_arn = each.value.arn # Access ARN using each.value
# policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
#   roles      = []             # Specify roles if needed
#   users      = []             # Specify users if needed

#   depends_on = [
#     aws_ecr_repository.repo
#   ]
# }

# data "aws_iam_policy_document" "example" {
#   statement {
#     sid    = "new test policy"
#     effect = "Allow"

#     principals {
#       type        = "AWS"
#       identifiers = []
#     }

#     actions = [
#       "ecr:GetDownloadUrlForLayer",
#       "ecr:BatchGetImage",
#       "ecr:BatchCheckLayerAvailability",
#       "ecr:PutImage",
#       "ecr:InitiateLayerUpload",
#       "ecr:UploadLayerPart",
#       "ecr:CompleteLayerUpload",
#       "ecr:DescribeRepositories",
#       "ecr:GetRepositoryPolicy",
#       "ecr:ListImages",
#       "ecr:DeleteRepository",
#       "ecr:BatchDeleteImage",
#       "ecr:SetRepositoryPolicy",
#       "ecr:DeleteRepositoryPolicy",
#     ]
#   }
# }

# resource "aws_ecr_repository_policy" "example" {
#   for_each   = var.ecr_repo_name
#   repository = aws_ecr_repository.repo[each.key].name
#   policy     = data.aws_iam_policy_document.example.json
# }

