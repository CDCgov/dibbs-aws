module "ecrRepo" {
    source = "./modules/ecr"

    ecr_repo_name = local.ecr_repo_name
}

module "ecs" {
    source = "./modules/ecs"

    retention_in_days = local.retention_in_days
    vpc_id                  = module.vpc.vpc_id
    public_subnet_ids       = module.vpc.public_subnets
    private_subnet_ids      = module.vpc.private_subnets
}

module "vpc" {
  source                      = "terraform-aws-modules/vpc/aws"
  #name                        = local.name
  cidr                        = "176.24.0.0/16"
  azs                         = ["us-east-1a", "us-east-1b"]
  private_subnets             = ["176.24.1.0/24", "176.24.3.0/24"]
  public_subnets              = ["176.24.2.0/24", "176.24.4.0/24"]
  enable_nat_gateway          = true
  single_nat_gateway          = true
  #default_security_group_name = "${local.name}-security-group"
}