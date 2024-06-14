output "ecr_viewer_s3_role_arn" {
  value = aws_iam_role.s3_role_for_ecr_viewer.arn
}

output "ecs_s3_bucket_name" {
  value = aws_s3_bucket.s3.id
}
