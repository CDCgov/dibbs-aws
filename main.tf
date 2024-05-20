module "ecrRepo" {
  source = "./modules/ecr"

  ecr_repo_name = {
    for key, value in local.ecr_repo_name :
    key => "${value}-repo"
  }

  ecs_task_execution_role = module.ecs.ecs_task_execution_role

  ghcr_token    = local.ghcr_token
  ghcr_username = local.ghcr_username

}

module "ecs" {
  source = "./modules/ecs"

  public_subnet_ids  = module.vpc.public_subnets
  private_subnet_ids = module.vpc.private_subnets
  retention_in_days  = local.retention_in_days
  vpc_id             = module.vpc.vpc_id
  cidr               = module.vpc.vpc_cidr_block


  aws_region               = local.aws_region
  aws_cloudwatch_log_group = local.aws_cloudwatch_log_group
}

module "vpc" {
  source                      = "terraform-aws-modules/vpc/aws"
  name                        = local.name
  cidr                        = "176.24.0.0/16"
  azs                         = ["us-east-1a", "us-east-1b"]
  private_subnets             = ["176.24.1.0/24", "176.24.3.0/24"]
  public_subnets              = ["176.24.2.0/24", "176.24.4.0/24"]
  enable_nat_gateway          = true
  single_nat_gateway          = true
  default_security_group_name = "${local.name}-security-group"
}
