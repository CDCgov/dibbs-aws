module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

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
  version = "0.1.2"
  # source = "../../../../terraform-aws-dibbs-ecr-viewer"

  public_subnet_ids  = flatten(module.vpc.public_subnets)
  private_subnet_ids = flatten(module.vpc.private_subnets)
  vpc_id             = module.vpc.vpc_id
  region             = var.region

  owner   = var.owner
  project = var.project
  tags    = local.tags

  # If intent is to pull from the phdi GHCR, set disable_ecr to true (default is false)
  # disable_ecr = true

  # If intent is to use the non-integrated viewer, set non_integrated_viewer to "true" (default is false)
  # non_integrated_viewer = "true"

  # If the intent is to make the ecr-viewer availabble on the public internet, set internal to false (default is true)
  # This requires an internet gateway to be present in the VPC.
  internal = var.internal

  # If the intent is to disable authentication, set ecr_viewer_app_env to "test" (default is "prod")
  # ecr_viewer_app_env = "test"
}
