resource "aws_s3_bucket" "s3" {
  bucket = var.s3_viewer_bucket_name
}
