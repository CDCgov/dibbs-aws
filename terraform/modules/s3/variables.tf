variable "region" {
  type = string
}

variable "s3_viewer_bucket_name" {
  type    = string
}

variable "s3_viewer_bucket_role_name" {
  type    = string
  default = "private"
}

variable "s3_viewer_bucket_policy_name" {
  type    = string
  default = "private"
}

variable "ecs_assume_role_policy" {
  type = string
}
