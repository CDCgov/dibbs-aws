variable "owner" {
  description = "The owner of the infrastructure (use snake or camel case, no spaces, up to 10 characters)"
  type        = string
  default     = "dibbs"
}
variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}
variable "availability_zones" {
  description = "The availability zones to use"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}
variable "ecs_alb_name" {
  description = "The name of the Application Load Balancer"
  type        = string
  default     = "dibbs-ecs-alb"
}
variable "ecs_app_task_name" {
  description = "The name of the ECS task"
  type        = string
  default     = "dibbs-ecs-task"
}
variable "ecs_app_service_name" {
  description = "The name of the ECS service"
  type        = string
  default     = "dibbs-ecs-asn"
}
variable "ecs_alb_sg" {
  description = "The security group for the Application Load Balancer"
  type        = string
  default     = "dibbs-ecs-albsg"
}
variable "cw_retention_in_days" {
  description = "The number of days to retain logs in CloudWatch"
  type        = number
  default     = 30
}
variable "ecs_cluster_name" {
  description = "The name of the target group"
  type        = string
  default     = "ecs-cluster"
}
variable "ecs_target_group_name" {
  description = "The name of the target group"
  type        = string
  default     = "dibbs-ecs-tgn"
}
variable "ecs_app_task_family" {
  description = "The family of the ECS task"
  type        = string
  default     = "dibbs-ecs-atf"
}
variable "ecs_task_execution_role_name" {
  description = "The name of the ECS task execution role"
  type        = string
  default     = "dibbs-ecs-tern"
}
variable "vpc" {
  description = "The name of the VPC"
  type        = string
  default     = "dibbs-ecs-vpc"
}
variable "private_subnets" {
  description = "The private subnets"
  type        = list(string)
  default     = ["176.24.1.0/24", "176.24.3.0/24"]
}
variable "public_subnets" {
  description = "The public subnets"
  type        = list(string)
  default     = ["176.24.2.0/24", "176.24.4.0/24"]
}
variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "176.24.0.0/16"
}
variable "ecs_cloudwatch_log_group" {
  description = "The name of the CloudWatch log group"
  type        = string
  default     = "/dibbs-ecs-cwlg"
}
variable "enable_nat_gateway" {
  description = "Enable NAT Gateway"
  type        = bool
  default     = true
}
variable "single_nat_gateway" {
  description = "Single NAT Gateway"
  type        = bool
  default     = true
}
variable "s3_viewer_bucket_name" {
  description = "The name of the viewer bucket"
  type        = string
  default     = "dibbs-s3-viewer"
}
variable "s3_viewer_bucket_role_name" {
  description = "The role for the viewer bucket"
  type        = string
  default     = "dibbs-s3-viewer-role"
}
variable "s3_viewer_bucket_policy_name" {
  description = "The policy name for the viewer bucket"
  type        = string
  default     = "dibbs-s3-viewer-policy"
}
variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

# Manually update to set the version you want to run
variable "phdi_version" {
  type        = string
  description = "PHDI container image version"
  default     = "v1.4.4"
}