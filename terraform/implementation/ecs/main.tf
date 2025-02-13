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
  public_subnet_ids  = flatten(module.vpc.public_subnets)
}

module "ecs" {
  # source  = "CDCgov/dibbs-ecr-viewer/aws"
  # version = "0.3.0"
  # source = "../../../../terraform-aws-dibbs-ecr-viewer"
  source = "git::https://github.com/CDCgov/terraform-aws-dibbs-ecr-viewer.git?ref=9d019bfb4379d062c32ab27160b29411628ef5a1"

  public_subnet_ids  = flatten(module.vpc.public_subnets)
  private_subnet_ids = flatten(module.vpc.private_subnets)
  vpc_id             = module.vpc.vpc_id
  region             = var.region

  owner        = var.owner
  project      = var.project
  tags         = local.tags
  phdi_version = var.phdi_version

  # The following variables will need to be configured depending on your requirements

  # If intent is to pull from the dibbs-ecr-viewer GHCR, set disable_ecr to true (default is false when not set)
  disable_ecr = false

  # If the intent is to make the ecr-viewer availabble on the public internet, set internal to false (default is true when not set)
  # This requires an internet gateway to be present in the VPC.
  internal = var.internal

  # If the intent is to enable https and port 443, pass the arn of the cert in AWS certificate manager. This cert will be applied to the load balancer. (default is "" when not set)
  certificate_arn = data.aws_acm_certificate.this.arn

  # To disable autoscaling, set enable_autoscaling to false (default is true when not set)
  enable_autoscaling = true

  # If the intent is to disable authentication, set nbs_auth to false (default is true when not set)
  nbs_auth = false

  # If intent is to use a metadata database for the ecr-viewer library, provider the required secrets manager names
  # Postgresql database example (default is "" when not set)
  secrets_manager_postgresql_connection_string_name = module.db.secrets_manager_postgresql_connection_string_name

  # SqlServer database example (default values are "" when not set)
  # secrets_manager_sqlserver_user_name = module.db.secrets_manager_sqlserver_user_name
  # secrets_manager_sqlserver_password_name = module.db.secrets_manager_sqlserver_password_name
  # secrets_manager_sqlserver_host_name = module.db.secrets_manager_sqlserver_host_name

  # dibbs_config_name can be a value found here under CONFIG_NAME: https://github.com/CDCgov/dibbs-ecr-viewer/blob/main/containers/ecr-viewer/environment.d.ts
  # This is used to configure the ecr-viewer application. (default is "" when not set)
  dibbs_config_name = "AWS_PG_NON_INTEGRATED"
}
