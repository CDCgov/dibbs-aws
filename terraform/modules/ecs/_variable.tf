variable "app_task_name" {
  description = "ECS Task Name"
  type        = string
}

variable "alb_name" {
  description = "ALB Name"
  type        = string
}

variable "availability_zones" {
  description = "AZs"
  type        = list(string)
}

variable "ecs_task_execution_role_arn" {
  description = "ECS Task Execution Role ARN"
  type        = string
}

variable "region" {
  description = "The AWS region things are created in"
}

variable "ecs_cloudwatch_group" {
  description = "AWS Cloudwatch Log Group for ECS"
}

variable "az_count" {
  description = "Number of AZs to cover in a given region"
  default     = "2"
}

variable "ecs_cluster_name" {
  type        = string
  description = "ECS Cluster Name"
  default     = "dibbs-ecs-cluster"
}

variable "env" {
  type        = string
  description = "ECS development environment"
  default     = "dev"
}

variable "health_check_path" {
  default = "/"
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "1024"
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "2048"
}

# Note:  Retention period can change (i.e. 0, 7, 14, 90, 180, etc.)
# See https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group
# In addition, if you want to delete log groups set "skip_destroy" to false
variable "retention_in_days" {
  type = number
}


#################
### NETWORKING ##
#################

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

variable "service_data" {
  type        = map(any)
  description = "Environment variables to pass to the container"
}
