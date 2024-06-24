# Credentials should be provided by using the AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY environment variables.
provider "aws" {
  region = var.region
  default_tags {
    tags = {
      Owner       = var.owner
      Environment = terraform.workspace
    }
  }
}

resource "random_string" "setup" {
  length  = 8
  special = false
  upper   = false
}

resource "aws_s3_bucket" "tfstate" {
  bucket = "${var.project}-tfstate-${var.owner}-${terraform.workspace}-${random_string.setup.result}"

  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "default" {
  bucket = aws_s3_bucket.tfstate.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  bucket = aws_s3_bucket.tfstate.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_versioning" "default" {
  bucket = aws_s3_bucket.tfstate.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Create a DynamoDB table for locking the state file
resource "aws_dynamodb_table" "tfstate_lock" {
  name         = "${var.project}-tfstate-lock-${var.owner}-${terraform.workspace}-${random_string.setup.result}"
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "local_file" "env" {
  content  = <<-EOT
    ENVIRONMENT=${terraform.workspace}
    BUCKET=${aws_s3_bucket.tfstate.bucket}
    DYNAMODB_TABLE=${aws_dynamodb_table.tfstate_lock.id}
    REGION=${var.region}
  EOT
  filename = "../.env"
}