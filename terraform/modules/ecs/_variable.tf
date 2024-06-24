variable "ecs_alb_name" {
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

variable "cw_retention_in_days" {
  type = number
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

variable "service_data" {
  type        = map(any)
  description = "Environment variables to pass to the container"
}

variable "cloudmap_namespace_name" {
  type        = string
  description = ""
}
variable "cloudmap_service_name" {
  type        = string
  description = ""
}

variable "appmesh_name" {
  type        = string
  description = ""
}