variable "alb_internal" {
  type        = bool
  description = "Flag to determine if the ALB is public (intended for external access) or private (only intended to be accessed within your AWS VPC)."
  default     = true
}
variable "appmesh_name" {
  type        = string
  description = "Name of the AWS App Mesh"
  default     = ""
}

variable "cloudmap_namespace_name" {
  type        = string
  description = "Name of the AWS Cloud Map namespace"
  default     = ""
}

variable "cloudmap_service_name" {
  type        = string
  description = "Name of the AWS Cloud Map service"
  default     = ""
}

variable "cw_retention_in_days" {
  type        = number
  description = "Retention period in days for CloudWatch logs"
  default     = 30
}

variable "ecs_alb_name" {
  description = "Name of the Application Load Balancer (ALB)"
  type        = string
  default     = ""
}

variable "ecs_alb_tg_name" {
  description = "Name of the ALB Target Group"
  type        = string
  default     = ""
}

variable "ecs_alb_sg" {
  type        = string
  description = "Name of the ECS ALB Security Group"
  default     = ""
}

variable "ecs_cluster_name" {
  type        = string
  description = "Name of the ECS Cluster"
  default     = ""
}

variable "ecs_cloudwatch_group" {
  type        = string
  description = "Name of the AWS CloudWatch Log Group for ECS"
  default     = ""
}

variable "ecs_task_execution_role_name" {
  type        = string
  description = "Name of the ECS Task Execution Role"
  default     = ""
}

variable "ecs_task_role_name" {
  type        = string
  description = "Name of the ECS Task Role"
  default     = ""
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
  type        = string
  description = "The AWS region where resources are created"
}

variable "s3_viewer_bucket_name" {
  type        = string
  description = "Name of the S3 bucket for the viewer"
  default     = ""
}

variable "s3_viewer_bucket_role_name" {
  type        = string
  description = "Name of the IAM role for the ecr-viewer bucket"
  default     = ""
}

variable "phdi_version" {
  type        = string
  description = "Version of the PHDI application"
  default     = "v1.6.4"
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
    registry_url   = string
    env_vars = list(object({
      name  = string
      value = string
    }))
  }))
  description = "Data for the DIBBS services"
  default     = {}
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC"
}

variable "owner" {
  type        = string
  description = "Owner of the resources"
  default     = "CDC"
}

variable "project" {
  type        = string
  description = "The project name"
  default     = "dibbs"
}

variable "disable_ecr" {
  type        = bool
  description = "Flag to disable the aws ecr service for docker image storage, defaults to false"
  default     = false
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources"
  default     = {}
}

variable "non_integrated_viewer" {
  type        = string
  description = "A flag to determine if the viewer is the non-integrated version"
  default     = "false"
}

variable "ecr_viewer_basepath" {
  type        = string
  description = "The basepath for the ecr-viewer"
  default     = "/ecr-viewer"
}