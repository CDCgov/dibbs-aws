variable "network_mode" {
    type        = string
    description = "ECS network mode"
    default     = "awsvpc"
}

#TODO: Double check with Emma to make sure the launch type is Fargate vs EC2
variable "launch_type" {
    description = "ECS launch type"
    type        = object ({
        type        = string
        cpu         = number
        memory      = number
    })
    default= {
        type    = "Fargate"
        cpu     = 256
        memory  = 512
    }
}

variable "task_family" {
    type        = string
    description = "ECS task family"
}