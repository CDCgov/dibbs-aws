variable "availability_zones" {
  description = "The availability zones to use"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "internal" {
  description = "Flag to determine if the several AWS resources are public (intended for external access, public internet) or private (only intended to be accessed within your AWS VPC or avaiable with other means, a transit gateway for example)."
  type        = bool
  default     = false
}

variable "owner" {
  description = "The owner of the infrastructure"
  type        = string
  default     = "skylight"
}

# Manually update to set the version you want to run
variable "phdi_version" {
  description = "PHDI container image version"
  type        = string
  default     = "44bc4b087f1f371f63ee270aba98589c542d72ba"
}

variable "database_type" {
  description = "The type of database to use (postgresql or sqlserver)"
  type        = string
  default     = ""
}

# variable "postgresql_connection_string_name" {
#   description = "The name of the secret in AWS Secrets Manager for the Postgresql connection string"
#   type        = string
#   default     = ""
# }

# variable "secrets_manager_sqlserver_host_name" {
#   description = "The name of the secret in AWS Secrets Manager for the SqlServer host name"
#   type        = string
#   default     = ""
# }

# variable "secrets_manager_sqlserver_password_name" {
#   description = "The name of the secret in AWS Secrets Manager for the SqlServer password"
#   type        = string
#   default     = ""
# }

# variable "secrets_manager_sqlserver_user_name" {
#   description = "The name of the secret in AWS Secrets Manager for the SqlServer user name"
#   type        = string
#   default     = ""
# }

variable "private_subnets" {
  description = "The private subnets"
  type        = list(string)
  default     = ["176.24.1.0/24", "176.24.3.0/24"]
}

variable "project" {
  description = "The project name"
  type        = string
  default     = "dibbs"
}

variable "public_subnets" {
  description = "The public subnets"
  type        = list(string)
  default     = ["176.24.2.0/24", "176.24.4.0/24"]
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "176.24.0.0/16"
}
