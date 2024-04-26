variable "create" {
  type        = bool
  description = "Determines whether resources will be created (affects all resources)"
  default     = true
}

variable "ecr_repo_name" {
    type        = string
    description = "ECR Repository Name"
    #default     = "dibbs-ecr-repository"
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
