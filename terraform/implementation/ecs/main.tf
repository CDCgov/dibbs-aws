data "aws_acm_certificate" "this" {
  domain   = "streamline.dibbs.cloud"
  types    = ["AMAZON_ISSUED"] # or ["ISSUED"] or ["PRIVATE"]
  statuses = ["ISSUED"]
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.16.0"

  name            = local.vpc_name
  cidr            = var.vpc_cidr
  azs             = var.availability_zones
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets
  # if internal is true, then the VPC will not have a NAT or internet gateway
  enable_nat_gateway = var.internal ? false : true
  single_nat_gateway = var.internal ? false : true
  create_igw         = var.internal ? false : true
  tags               = local.tags
}

module "db" {
  source = "../../modules/db"

  vpc_id             = module.vpc.vpc_id
  cidr               = var.vpc_cidr
  owner              = var.owner
  project            = var.project
  database_type      = var.database_type
  tags               = local.tags
  private_subnet_ids = flatten(module.vpc.private_subnets)
}

# module "ecs" {
#   # source  = "CDCgov/dibbs-ecr-viewer/aws"
#   # version = "0.3.0"
#   source = "../../../../terraform-aws-dibbs-ecr-viewer"

#   public_subnet_ids  = flatten(module.vpc.public_subnets)
#   private_subnet_ids = flatten(module.vpc.private_subnets)
#   vpc_id             = module.vpc.vpc_id
#   region             = var.region

#   owner        = var.owner
#   project      = var.project
#   tags         = local.tags
#   phdi_version = var.phdi_version

#   # If intent is to pull from the phdi GHCR, set disable_ecr to true (default is false)
#   # disable_ecr = true

#   # If the intent is to make the ecr-viewer availabble on the public internet, set internal to false (default is true)
#   # This requires an internet gateway to be present in the VPC.
#   internal = var.internal

#   # If the intent is to enable https and port 443, pass the arn of the cert in AWS certificate manager. This cert will be applied to the load balancer. (default is "")
#   certificate_arn = data.aws_acm_certificate.this.arn

#   # If the intent is to disable authentication, set ecr_viewer_app_env to "test" (default is "prod")
#   ecr_viewer_app_env = "test"

#   # To disable autoscaling, set enable_autoscaling to false (default is true)
#   # enable_autoscaling = false

#   # If intent is to use a metadata database for polutating the ecr-viewer library, setup the database data object to connect to the database (supported databases are postgres and sqlserver)
#   # Postgresql database example
#   # If the secrets manager secret is not available or doesn't exist, the value will be false
#   # secrets_manager_postgresql_connection_string_name = ""
#   # If the secrets manager secret exists, the value will be the name of the secret
#   secrets_manager_postgresql_connection_string_name = "${local.vpc_name}_postgresql_connection_string"

#   # SqlServer database example
#   # If the secrets manager secret is not available or doesn't exist, the value will be false
#   # secrets_manager_sqlserver_user_name = var.database_type == "sqlserver" ? var.secrets_manager_sqlserver_user_name : ""
#   # secrets_manager_sqlserver_password_name = var.database_type == "sqlserver" ? var.secrets_manager_sqlserver_password_name : ""
#   # secrets_manager_sqlserver_host_name = var.database_type == "sqlserver" ? var.secrets_manager_sqlserver_host_name : ""
#   # If the secrets manager secret exists, the value will be the name of the secret
#   # secrets_manager_sqlserver_user_name = "${local.vpc_name}-ecr-viewer-sqlserver-user-name-12345"
#   # secrets_manager_sqlserver_password_name = "${local.vpc_name}-ecr-viewer-sqlserver-password-12345"
#   # secrets_manager_sqlserver_host_name = "${local.vpc_name}-ecr-viewer-sqlserver-host-12345"
#   dibbs_config_name = "AWS_PG_NON_INTEGRATED"
# }
