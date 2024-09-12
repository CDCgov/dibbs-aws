variable "oidc_github_repo" {
  description = "The GitHub repository for OIDC"
  type        = string
  default     = ""
}

variable "owner" {
  description = "The owner of the project"
  type        = string
  default     = "skylight"
}

variable "project" {
  description = "The name of the project"
  type        = string
  default     = "dibbs-ce"
}

variable "region" {
  type        = string
  description = "The AWS region where resources are created"
  default     = ""
}

variable "workspace" {
  default     = ""
  type        = string
  description = "terraform workspace that OIDC will have permissions to"
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC"
  default     = ""
}

variable "state_bucket_arn" {
  type        = string
  description = "The ARN of the S3 bucket for state"
  default     = ""
}

variable "dynamodb_table_arn" {
  type        = string
  description = "The ARN of the DynamoDB table for state"
  default     = ""
}