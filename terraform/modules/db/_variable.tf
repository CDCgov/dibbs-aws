variable "vpc_id" {
  type        = string
  description = "ID of the VPC"
}

variable "owner" {
  description = "The owner of the infrastructure"
  type        = string
  default     = "skylight"
}

variable "project" {
  description = "The project name"
  type        = string
  default     = "dibbs"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources"
  default     = {}
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of private subnet IDs"
}

variable "database_type" {
  description = "The type of database to use (postgresql or sqlserver)"
  type        = string
  default     = ""
}

variable "cidr" {
  type        = string
  description = "The CIDR block for the VPC"
  default     = ""
}
