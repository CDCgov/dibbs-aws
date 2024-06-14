variable "region" {
  type    = string
  default = "us-east-1"
}

variable "s3_name" {
  type    = string
  default = "ecr-fhir-storage"
}

variable "ecs_assume_role_policy" {
  type = string
}
