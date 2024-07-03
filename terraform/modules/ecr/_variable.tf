variable "region" {
  type        = string
  description = "The AWS region where resources are created"
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