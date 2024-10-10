variable "owner" {
  description = "The owner of the project"
  type        = string
  default     = "skylight"
}

variable "project" {
  description = "The name of the project"
  type        = string
  default     = "dibbs-ce"
}

variable "region" {
  type        = string
  description = "The AWS region where resources are created"
  default     = "us-east-1"
}

variable "identifier" {
  type    = string
  default = ""
}