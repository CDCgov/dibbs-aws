variable "app_count" {
    description = "Number of docker containers to run"
    default = 3
}

variable "app_image" {
    description = "Docker image to run in the ECS cluster"
    default = "bradfordhamilton/crystal_blockchain:latest"
}

variable "app_port" {
    description = "Port exposed by the docker image to redirect traffic to"
    default = 3000

}

variable "aws_region" {
    description = "The AWS region things are created in"
}

variable "az_count" {
    description = "Number of AZs to cover in a given region"
    default = "2"
}

variable "ec2_task_execution_role_name" {
    description = "ECS task execution role name"
    default = "myEcsTaskExecutionRole"
}

variable "ecs_auto_scale_role_name" {
    description = "ECS auto scale role name"
    default = "myEcsAutoScaleRole"
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

variable "health_check_path" {
  default = "/health_checks"
}

variable "fargate_cpu" {
    description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
    default = "1024"
}

variable "fargate_memory" {
    description = "Fargate instance memory to provision (in MiB)"
    default = "2048"
}