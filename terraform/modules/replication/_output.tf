output "s3_replication_bucket_arn" {
  value = aws_s3_bucket.replication.arn
}

output "s3_replication_bucket_name" {
  value = aws_s3_bucket.replication.bucket
}