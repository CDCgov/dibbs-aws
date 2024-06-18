variable "ecr_repo_names" {
  type = set(string)
  # default = [
  #   "fhir-converter",
  #   "ingestion",
  #   "ecr-viewer",
  #   "validation",
  #   "orchestration"
  # ]
}

variable "ecs_task_execution_role" {
  type        = string
  description = "ECS Task Execution Role"
}

variable "ecs_cluster_name" {
  type        = string
  description = "ECS Cluster Name"
}

variable "lifecycle_policy" {
  type        = string
  description = "ECR repository lifecycle policy document. Used to override the default policy."
  # default     = ""
}

variable "tags" {
  type        = map(any)
  description = "Additional tags to apply."
  # default     = {}
}

variable "aws_caller_identity" {
  type        = string
  description = "AWS Caller Identity"
}

variable "region" {
  type        = string
  description = "AWS region"
}