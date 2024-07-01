variable "appmesh_name" {
  type        = string
  description = ""
}

variable "availability_zones" {
  description = "AZs"
  type        = list(string)
}

variable "az_count" {
  description = "Number of AZs to cover in a given region"
  default     = "2"
}

variable "cloudmap_namespace_name" {
  type        = string
  description = ""
}

variable "cloudmap_service_name" {
  type        = string
  description = ""
}

variable "cw_retention_in_days" {
  type = number
}

variable "ecs_alb_name" {
  description = "ALB Name"
  type        = string
}

variable "ecs_alb_tg_name" {
  description = "ALB Target Group Name"
  type        = string
}

variable "ecs_cluster_name" {
  type        = string
  description = "ECS Cluster Name"
}

variable "ecs_cloudwatch_group" {
  description = "AWS Cloudwatch Log Group for ECS"
}

variable "ecs_task_execution_role_name" {
  type        = string
  description = "ECS Task Execution Role Name"
}

variable "ecs_task_role_name" {
  type        = string
  description = "ECS Task Role Name"
}

variable "health_check_path" {
  default = "/"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of private subnet IDs"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "List of public subnet IDs"
}

variable "region" {
  description = "The AWS region things are created in"
}

variable "s3_viewer_bucket_name" {
  type = string
}

variable "s3_viewer_bucket_role_name" {
  type    = string
}

variable "service_data" {
  type = map(object({
    short_name     = string
    fargate_cpu    = number
    fargate_memory = number
    app_count      = number
    app_image      = string
    app_version    = string
    container_port = number
    host_port      = number
    public         = bool
    env_vars       = list(object({
      name  = string
      value = string
    }))
  }))
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC"
}