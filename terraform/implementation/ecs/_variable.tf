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
  default     = "3.0.0-Beta"
}

variable "dibbs_config_name" {
  description = "The name of the DIBBS configuration"
  type        = string
  default     = "AWS_PG_NON_INTEGRATED"
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

variable "auth_provider" {
  description = "The authentication provider used. Either keycloak or ad."
  type        = string
  default     = ""
}

variable "auth_client_id" {
  description = "The application/client id used to idenitfy the client"
  type        = string
  default     = ""
}

variable "auth_issuer" {
  description = "Additional information used during authentication process. For Azure AD, this will be the 'Tenant Id'. For Keycloak, this will be the url issuer including the realm - e.g. https://my-keycloak-domain.com/realms/My_Realm"
  type        = string
  default     = ""
}

variable "auth_url" {
  description = "Optional. The full URL of the auth api. By default https://your-site.com/ecr-viewer/api/auth."
  type        = string
  default     = ""
}

variable "secrets_manager_auth_secret_version" {
  description = "The secret containing the auth secret. This is used by eCR viewer to encrypt authentication. This can be generated by running `openssl rand -base64 32`."
  type        = string
  default     = ""
  sensitive   = true
}

variable "secrets_manager_auth_client_secret_version" {
  description = "The secret containing the auth client secret. This is the secret that comes from the authentication provider."
  type        = string
  default     = ""
  sensitive   = true
}
