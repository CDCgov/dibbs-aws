variable "internal" {
  type        = bool
  description = "Flag to determine if the several AWS resources are public (intended for external access, public internet) or private (only intended to be accessed within your AWS VPC or avaiable with other means, a transit gateway for example)."
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
  default     = "v1.6.9"
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

variable "ecr_viewer_app_env" {
  type        = string
  description = "The current environment that is running. This may modify behavior of auth between dev and prod."
  default     = "prod"
}

variable "ecr_viewer_auth_pub_key" {
  type        = string
  description = "The public key used to validate the incoming authenication for the eCR Viewer."
  default     = <<EOT
-----BEGIN PUBLIC KEY-----
MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAqjrH9PprQCB5dX15zYfd
S6K2ezNi/ZOu8vKEhQuLqwHACy1iUt1Yyp2PZLIV7FVDgBHMMVWPVx3GJ2wEyaJw
MHkv6XNpUpWLhbs0V1T7o/OZfEIqcNua07OEoBxX9vhKIHtaksWdoMyKRXQJz0js
oWpawfOWxETnLqGvybT4yvY2RJhquTXLcLu90L4LdvIkADIZshaOtAU/OwI5ATcb
fE3ip15E6jIoUm7FAtfRiuncpI5l/LJPP6fvwf8QCbbUJBZklLqcUuf4qe/L/nIq
pIONb8KZFWPhnGeRZ9bwIcqYWt3LAAshQLSGEYl2PGXaqbkUD2XLETSKDjisxd0g
9j8bIMPgBKi+dBYcmBZnR7DxJe+vEDDw8prHG/+HRy5fim/BcibTKnIl8PR5yqHa
mWQo7N+xXhILdD9e33KLRgbg97+erHqvHlNMdwDhAfrBT+W6GCdPwp3cePPsbhsc
oGSHOUDhzyAujr0J8h5WmZDGUNWjGzWqubNZD8dBXB8x+9dDoWhfM82nw0pvAeKf
wJodvn3Qo8/S5hxJ6HyGkUTANKN8IxWh/6R5biET5BuztZP6jfPEaOAnt6sq+C38
hR9rUr59dP2BTlcJ19ZXobLwuJEa81S5BrcbDwYNOAzC8jl2EV1i4bQIwJJaY27X
Iynom6unaheZpS4DFIh2w9UCAwEAAQ==
-----END PUBLIC KEY-----
          EOT
}
