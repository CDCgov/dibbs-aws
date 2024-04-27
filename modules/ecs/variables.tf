variable "application_load_balancer_name" {
  type        = string
  description = ""
  default     = ""
}

variable "container_port" {
  type        = string
  description = ""
  default     = ""
}

variable "desired_count" {
  type        = string
  description = "The desired number of tasks to start with. Set this to 0 if using DAEMON Service type. (FARGATE does not support DAEMON Service type)"
  default     = "1"
}

variable "ecs_cluster_name" {
  type          = string
  description   = "ECS Cluster Name"
  default       = "dibbs-ecs-cluster"
}

variable "ecs_task_execution_role_name" {
  type          = string
  description   = "ECS TaskExecutionRole Name"
  default       = "dibbs-tracking-ecsTaskExecutionRole"
}

variable "env" {
  type        = string
  description = "ECS development environment"
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
    default = {
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
  type        = string
  description = "AWS region"
  default     = "us-east-1"
}

variable "repository_name" {
  type          = string
  description   = "ECR Repository Name"
  default       = "dibbs-ecs-repository"
}

variable "tags" {
  type        = map(string)
  description = "tags to be added to sub resources"
  default     = null
}

variable "target_grp_name" {
  type        = string
  description = ""
  default     = ""
}

variable "task_name" {
  type        = string
  description = "ECS task name"
  default     = "dibbs-ecs-task"
}

variable "service_name" {
  type          = string
  description   = "ECS Service Name"
  default       ="dibbs-ecs-service"
}

