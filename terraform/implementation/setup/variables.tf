variable "owner" {
  type = string
}
variable "project" {
  type = string
}
variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}
