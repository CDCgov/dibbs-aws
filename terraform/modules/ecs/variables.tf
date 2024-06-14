variable "app_count" {
  description = "Number of docker containers to run"
  type        = number
  default     = 1
}

variable "app_image" {
  description = "Docker image to run in the ECS cluster"
  default     = "bradfordhamilton/crystal_blockchain:latest"
}

variable "app_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  type        = number
  default     = 8080
}

variable "app_service_name" {
  description = "ECS Service Name"
  type        = string
}

variable "app_task_name" {
  description = "ECS Task Name"
  type        = string
}

variable "alb_name" {
  description = "ALB Name"
  type        = string
}

variable "availability_zones" {
  description = "us-east-1 AZs"
  type        = list(string)
}

variable "container_port" {
  description = "Container Port"
  type        = number
}

variable "ecs_task_execution_role_arn" {
  description = "ECS Task Execution Role ARN"
  type        = string
}

variable "aws_region" {
  description = "The AWS region things are created in"
}

variable "aws_cloudwatch_log_group" {
  description = "AWS Cloudwatch Log Group for ECS"
}

variable "az_count" {
  description = "Number of AZs to cover in a given region"
  default     = "2"
}

variable "ecs_app_task_family" {
  description = "ECS Task Family"
  type        = string
}

variable "ecs_s3_bucket_name" {
  description = "The name fo the ECS bucket for ecr-viewer"
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

variable "ecr_repo_url" {
  type        = list(string)
  description = "ECR repository urls"
}

variable "ecr_repos" {
  type        = set(string)
  description = "ECR repository name(s)"
}

variable "health_check_path" {
  default = "/fhir-converter"
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "1024"
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "2048"
}

variable "target_group_name" {
  description = "ALB Target Group Name"
  type        = string
}

# Note:  Retention period can change (i.e. 0, 7, 14, 90, 180, etc.)
# See https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group
# In addition, if you want to delete log groups set "skip_destroy" to false
variable "retention_in_days" {
  type        = number
  description = 30
}


#################
### NETWORKING ##
#################

variable "cidr" {
  type        = string
  description = "CIDR block"
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
