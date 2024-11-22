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

module "ecs" {
  source  = "CDCgov/dibbs-ecr-viewer/aws"
  version = "0.2.1"
  # source = "../../../../terraform-aws-dibbs-ecr-viewer"

  public_subnet_ids  = flatten(module.vpc.public_subnets)
  private_subnet_ids = flatten(module.vpc.private_subnets)
  vpc_id             = module.vpc.vpc_id
  region             = var.region

  owner        = var.owner
  project      = var.project
  tags         = local.tags
  phdi_version = var.phdi_version

  # If intent is to pull from the phdi GHCR, set disable_ecr to true (default is false)
  # disable_ecr = true

  # If the intent is to make the ecr-viewer availabble on the public internet, set internal to false (default is true)
  # This requires an internet gateway to be present in the VPC.
  internal = var.internal

  # If the intent is to enable https and port 443, pass the arn of the cert in AWS certificate manager. This cert will be applied to the load balancer. (default is "")
  certificate_arn = data.aws_acm_certificate.this.arn

  # If the intent is to disable authentication, set ecr_viewer_app_env to "test" (default is "prod")
  # ecr_viewer_app_env = "test"

  # If intent is to use a metadata database for polutating the ecr-viewer library, setup the database data object to connect to the database (supported databases are postgres and sqlserver)
  # Postgresql database example
  # postgres_database_data = {
  #   non_integrated_viewer = "true"
  #   metadata_database_type = "postgres"
  #   metadata_database_schema = "core" # (core or extended)
  #   secrets_manager_postgres_database_url_name = "prod/testSecret"
  # }
  # SqlServer database example
  # sqlserver_database_data = {
  #   non_integrated_viewer = "true"
  #   metadata_database_type = "sqlserver"
  #   metadata_database_schema = "core" # (core or extended)
  #   secrets_manager_sqlserver_user_name = "prod/testSecret"
  #   secrets_manager_sqlserver_password_name = "prod/testSecret"
  #   secrets_manager_sqlserver_host_name = "prod/testSecret"
  # }
}
