module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name               = local.vpc_name
  cidr               = var.vpc_cidr
  azs                = var.availability_zones
  private_subnets    = var.private_subnets
  public_subnets     = var.public_subnets
  enable_nat_gateway = var.enable_nat_gateway
  single_nat_gateway = var.single_nat_gateway
  create_igw         = var.create_internet_gateway
  tags               = local.tags
}

module "vpc_test" {
  source = "terraform-aws-modules/vpc/aws"

  name               = "alis-test-vpc"
  cidr               = "176.29.0.0/16"
  azs                = var.availability_zones
  private_subnets    = ["176.29.1.0/24", "176.29.3.0/24"]
  public_subnets     = ["176.29.2.0/24", "176.29.4.0/24"]
  enable_nat_gateway = var.enable_nat_gateway
  single_nat_gateway = var.single_nat_gateway
  tags               = local.tags
}

module "ecs" {
  source = "../../modules/ecs"

  public_subnet_ids  = flatten(module.vpc.public_subnets)
  private_subnet_ids = flatten(module.vpc.private_subnets)
  vpc_id             = module.vpc.vpc_id
  region             = var.region
  # alb_internal       = false

  owner   = var.owner
  project = var.project
  tags    = local.tags
  
  # If intent is to pull from the phdi GHCR, set disable_ecr to true (default is false)
  # disable_ecr = true
  # If intent is to use the non-integrated viewer, set non_integrated_viewer to true (default is false)
  # non_integrated_viewer = "true"
}
