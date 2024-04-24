variable "network_mode" {
    type        = string
    description = "ECS network mode"
    default     = "awsvpc"
}

#TODO: Double check with Emma to make sure the launch type is Fargate vs EC2
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

variable "task_family" {
    type        = string
    description = "ECS task family"
}

# Note:  Retention period can change (i.e. 0, 7, 14, 90, 180, etc.)
# See https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group
# In addition, if you want to delete log groups set "skip_destroy" to false
variable "retention_in_days" {
    type                = number
    description         = 30
}

variable "tags" {
  description = "tags to be added to sub resources"
  type        = map(string)
  default     = null
}

#variable "ecr_image_tag" {
#  description = "ECR image tag"
#  type        = map(string)
#}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "env" {
  description = "ECS development environment"
  type        = string
  default     = "dev"
}

variable "db_endpoint" {}

variable "db_name" {}

variable "service_name" {
  description   = "ECS Service Name"
  type          = string
  default       ="dibbs-ecs-service"
}

variable "repository_name" {
  description   = "ECR Repository Name"
  type          = string
  default       = "dibbs-ecs-repository"
}