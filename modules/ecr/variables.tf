variable "create" {
  type        = bool
  description = "Determines whether resources will be created (affects all resources)"
  default     = true
}

variable "ecr_policy" {
  type        = string
  description = "ECR IAM permission policy for external access."
  default     = ""
}

variable "ecr_repo_name" {
  type        = list(string)
  description = "ECR Repository Name"
  default     = ["fhir-converter", "ingestion", "message-parser", "orchestration"]
}

variable "ecs_task_execution_role" {
  type        = string
  description = "ECS Task Execution Role"
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
### DOCKER PROVIDER ##
######################

variable "ecr_address" {
  type        = string
  description = "Elastic Container Registry Address"
  default     = "https://339712971032.dkr.ecr.us-east-1.amazonaws.com"
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
