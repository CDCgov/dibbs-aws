resource "random_string" "replication" {
  length  = 8
  special = false
  upper   = false
}

resource "aws_s3_bucket" "replication" {
  bucket        = var.s3_replication_bucket_name
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "replication" {
  bucket = aws_s3_bucket.replication.id
  versioning_configuration {
    status = "Enabled"
  }
}