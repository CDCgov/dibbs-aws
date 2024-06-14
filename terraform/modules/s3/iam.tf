# s3 bucket role
resource "aws_iam_role" "s3_role_for_ecr_viewer" {
  name               = var.s3_viewer_bucket_role_name
  assume_role_policy = var.ecs_assume_role_policy
}

resource "aws_iam_policy" "s3_bucket_ecr_viewer_policy" {
  name        = var.s3_viewer_bucket_policy_name
  description = "Policy for ECR-Viewer and S3 for DIBBS-AWS"
  policy      = data.aws_iam_policy_document.ecr_viewer_s3_policy.json
}

resource "aws_iam_role_policy_attachment" "s3_bucket_ecr_viewer_policy" {
  role       = aws_iam_role.s3_role_for_ecr_viewer.name
  policy_arn = aws_iam_policy.s3_bucket_ecr_viewer_policy.arn
}
