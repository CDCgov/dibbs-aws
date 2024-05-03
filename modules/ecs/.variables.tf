variable "alb_sg" {
  description = "ECS Application Load Balancer Security Group"
  type        = string
}

variable "app_task_family" {
  description = "ECS Task Family"
  type        = string
}

variable "app_task_name" {
  description = "ECS Task Name"
  type        = string
}

variable "application_load_balancer_name" {
  type        = string
  description = ""
  default     = ""
}

variable "az_count" {
  description = "Number of AZs to cover in a given region"
  default = "2"
}

variable "container_port" {
  type        = number
  description = "ECS Container Port"
}

variable "desired_count" {
  type        = number
  description = "The desired number of tasks to start with. Set this to 0 if using DAEMON Service type. (FARGATE does not support DAEMON Service type)"
  default     = 2
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

variable "ecr_repo_url" {
  description = "ECR Repo URL"
  type        = string
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
  description   = "DIBBS ECR Repository Name"
  default       = "dibbs-ecs-repository"
}

variable "service_name" {
  type          = string
  description   = "ECS Service Name"
  default       ="dibbs-ecs-service"
}

variable "tags" {
  type        = map(string)
  description = "tags to be added to sub resources"
  default     = null
}

variable "target_grp_name" {
  type        = string
  description = "DIBBS ECS Target Group Name"
  default     = "ecs-target-group"
}

variable "task_name" {
  type        = string
  description = "ECS task name"
  default     = "dibbs-ecs-task"
}

################################################################################
# Network Configuration
################################################################################

variable "app_port" {
    description = "Port exposed by the docker image to redirect traffic to"
    default = 3000

}

variable "availability_zones" {
  description = "us-east-1 AZs"
  type        = list(string)
}

variable "network_mode" {
    type        = string
    description = "ECS network mode"
    default     = "awsvpc"
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "List of public subnet IDs"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of private subnet IDs"
}
