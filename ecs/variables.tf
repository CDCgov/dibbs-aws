variable "create" {
  description = "Determines whether resources will be created (affects all resources)"
  type        = bool
  default     = true
}

variable "db_endpoint" {}

variable "db_name" {}

#variable "ecr_image_tag" {
#  description = "ECR image tag"
#  type        = map(string)
#}

variable "env" {
  description = "ECS development environment"
  type        = string
  default     = "dev"
}

# Note: The launch type can either be FARGATE or EC2
variable "launch_type" {
    description = "ECS launch type"
    type        = object ({
        type        = string
        cpu         = number
        memory      = number
    })
    default= {
        type    = "FARGATE"
        cpu     = 256
        memory  = 512
    }
}

variable "network_mode" {
    type        = string
    description = "ECS network mode"
    default     = "awsvpc"
}

# Note:  Retention period can change (i.e. 0, 7, 14, 90, 180, etc.)
# See https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group
# In addition, if you want to delete log groups set "skip_destroy" to false
variable "retention_in_days" {
    type                = number
    description         = 30
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "repository_name" {
  description   = "ECR Repository Name"
  type          = string
  default       = "dibbs-ecs-repository"
}

variable "tags" {
  description = "tags to be added to sub resources"
  type        = map(string)
  default     = null
}

#variable "task_family" {
#    type        = string
#    description = "ECS task family"
#}

variable "task_name" {
  type        = string
  description = "ECS task name"
  default     = "dibbs-ecs-task"
}

variable "service_name" {
  description   = "ECS Service Name"
  type          = string
  default       ="dibbs-ecs-service"
}

################################################################################
# Registry Replication Configuration
################################################################################

variable "create_registry_replication_configuration" {
  description = "Determines whether a registry replication configuration will be created"
  type        = bool
  default     = false
}

variable "registry_replication_rules" {
  description = "The replication rules for a replication configuration. A maximum of 10 are allowed"
  type        = any
  default     = []
}