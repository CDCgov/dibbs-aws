variable "ecs_task_execution_role_name" {
  type        = string
  description = "ECS task execution role name"
}
variable "aws_caller_identity" {
  type        = string
  description = "AWS Caller Identity"
}
variable "ecs_cluster_name" {
  type        = string
  description = "ECS Cluster Name"
}
variable "region" {
  type = string
}