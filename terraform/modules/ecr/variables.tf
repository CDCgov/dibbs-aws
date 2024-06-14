variable "create" {
  type        = bool
  description = "Determines whether resources will be created (affects all resources)"
  default     = true
}

variable "ecr_repos" {
  type = set(string)
  default = [
    "fhir-converter",
    "ingestion",
    "ecr-viewer",
    "validation",
    "orchestration"
  ]
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
  default     = ""
}

################################################################################
# Registry Replication Configuration
################################################################################

variable "create_registry_replication_configuration" {
  type        = bool
  description = "Determines whether a registry replication configuration will be created"
  default     = false
}

variable "registry_replication_rules" {
  description = "The replication rules for a replication configuration. A maximum of 10 are allowed"
  type        = any
  default     = []
}

variable "repository_image_tag_mutability" {
  description = "The tag mutability setting for the repository. Must be one of: `MUTABLE` or `IMMUTABLE`."
  type        = string
  default     = "MUTABLE"
}

variable "tags" {
  type        = map(any)
  description = "Additional tags to apply."
  default     = {}
}

######################
###### GHCR INFO #####
######################

variable "ghcr_username" {
  type        = string
  description = "GitHub Container Registry username."
}

variable "ghcr_token" {
  type        = string
  description = "GitHub Container Registry token."
}

variable "aws_caller_identity" {
  type        = string
  description = "AWS Caller Identity"
}

variable "region" {
  type        = string
  description = "AWS region"
}