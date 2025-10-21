data "aws_acm_certificate" "this" {
  domain   = "*.dibbs.cloud"
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
  tags               = local.tags
  private_subnet_ids = flatten(module.vpc.private_subnets)
  public_subnet_ids  = flatten(module.vpc.public_subnets)
  ssh_key_name       = var.ssh_key_name
  # determines which database is launched, required for the ec2 instance to know which database to setup
  database_type = var.database_type
}

module "ecs" {
  source  = "CDCgov/dibbs-ecr-viewer/aws"
  version = "0.8.8"
  # github branch source 
  # source = "git::https://github.com/CDCgov/terraform-aws-dibbs-ecr-viewer.git?ref=gordon/session-duration-env-var"

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
  disable_ecr = true

  # If the intent is to make the ecr-viewer availabble on the public internet, set internal to false (default is true when not set)
  # This requires an internet gateway to be present in the VPC.
  internal = var.internal

  # If the intent is to enable https and port 443, pass the arn of the cert in AWS certificate manager. This cert will be applied to the load balancer. (default is "" when not set)
  certificate_arn = data.aws_acm_certificate.this.arn

  # To disable autoscaling, set enable_autoscaling to false (default is true when not set)
  enable_autoscaling = true

  # If intent is to use a metadata database for the ecr-viewer library, provider the required secrets manager names
  # Postgresql database example (default is "" when not set)
  secrets_manager_connection_string_version = var.database_type == "postgresql" || var.database_type == "sqlserver" ? module.db.secrets_manager_database_connection_string_version : ""

  # SqlServer database example (default values are "" when not set)
  # secrets_manager_sqlserver_user_version = module.db.secrets_manager_sqlserver_user_version
  # secrets_manager_sqlserver_password_version = module.db.secrets_manager_sqlserver_password_version
  # secrets_manager_sqlserver_host_version = module.db.secrets_manager_sqlserver_host_version

  # dibbs_config_name can be a value found here under CONFIG_NAME: https://github.com/CDCgov/dibbs-ecr-viewer/blob/main/containers/ecr-viewer/environment.d.ts
  # This is used to configure the ecr-viewer application. (default is "" when not set)
  dibbs_config_name = var.dibbs_config_name

  # non integrated auth provider example (default values are "" when not set)
  auth_provider                                              = var.auth_provider
  auth_client_id                                             = var.auth_client_id
  auth_issuer                                                = var.auth_issuer
  auth_url                                                   = var.auth_url
  auth_session_duration_min                                  = var.auth_session_duration_min
  secrets_manager_auth_secret_version                        = var.secrets_manager_auth_secret_version
  secrets_manager_auth_client_secret_version                 = var.secrets_manager_auth_client_secret_version
  secrets_manager_metadata_database_migration_secret_version = var.secrets_manager_metadata_database_migration_secret_version

  ecr_viewer_auth_pub_key     = var.nbs_pub_key
  ecr_viewer_auth_api_pub_key = var.nbs_pub_key

  override_autoscaling = {
    fhir-converter = {
      cpu           = 2048
      memory        = 4096
      max_capacity  = 5
      min_capacity  = 1
      target_cpu    = 60
      target_memory = 70
    }
  }
}

resource "aws_route53_record" "alb" {
  zone_id = var.route53_hosted_zone_id
  name    = "${terraform.workspace}.dibbs.cloud"
  type    = "CNAME"
  ttl     = 60
  records = [module.ecs.alb_dns_name]
}
