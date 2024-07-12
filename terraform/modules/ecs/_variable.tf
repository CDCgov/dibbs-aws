variable "appmesh_name" {
  type        = string
  description = "Name of the AWS App Mesh"
}

variable "cloudmap_namespace_name" {
  type        = string
  description = "Name of the AWS Cloud Map namespace"
}

variable "cloudmap_service_name" {
  type        = string
  description = "Name of the AWS Cloud Map service"
}

variable "cw_retention_in_days" {
  type        = number
  description = "Retention period in days for CloudWatch logs"
}

variable "ecs_alb_name" {
  description = "Name of the Application Load Balancer (ALB)"
  type        = string
}

variable "ecs_alb_tg_name" {
  description = "Name of the ALB Target Group"
  type        = string
}

variable "ecs_cluster_name" {
  type        = string
  description = "Name of the ECS Cluster"
}

variable "ecs_cloudwatch_group" {
  description = "Name of the AWS CloudWatch Log Group for ECS"
}

variable "ecs_task_execution_role_name" {
  type        = string
  description = "Name of the ECS Task Execution Role"
}

variable "ecs_task_role_name" {
  type        = string
  description = "Name of the ECS Task Role"
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
}

variable "s3_viewer_bucket_role_name" {
  type        = string
  description = "Name of the IAM role for the ecr-viewer bucket"
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
    env_vars = list(object({
      name  = string
      value = string
    }))
  }))
  description = "Data for the DIBBS services"
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC"
}
