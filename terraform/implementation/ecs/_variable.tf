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
  default     = "v2.0.0-beta"
}

variable "database_type" {
  description = "The type of database to use (postgresql or sqlserver)"
  type        = string
  default     = "postgresql"
}

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

variable "ssh_key_name" {
  description = "The name of the SSH key to use for the instances"
  type        = string
  default     = ""
}

variable "route53_hosted_zone_id" {
  description = "The Route53 hosted zone ID"
  type        = string
  default     = ""
  sensitive   = true
}