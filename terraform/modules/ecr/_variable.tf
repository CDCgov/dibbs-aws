variable "service_data" {}

variable "ecs_task_execution_role" {
  type        = string
  description = "ECS Task Execution Role"
}

variable "ecs_cluster_name" {
  type        = string
  description = "ECS Cluster Name"
}

variable "aws_caller_identity" {
  type        = string
  description = "AWS Caller Identity"
}

variable "region" {
  type        = string
  description = "AWS region"
}

variable "phdi_version" {
  type        = string
  description = "PHDI container image version"
}