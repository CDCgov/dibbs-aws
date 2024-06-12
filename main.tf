module "ecrRepo" {
  source = "./modules/ecr"

  ecr_repo_name = local.ecr_repo_name

  ecs_task_execution_role = module.ecs.ecs_task_execution_role.arn

  ghcr_token    = local.ghcr_token
  ghcr_username = local.ghcr_username

}

module "ecs" {
  source = "./modules/ecs"

  public_subnet_ids  = flatten(module.vpc.public_subnets)
  private_subnet_ids = flatten(module.vpc.private_subnets)
  retention_in_days  = local.retention_in_days
  vpc_id             = module.vpc.vpc_id
  cidr               = module.vpc.vpc_cidr_block

  app_service_name = local.app_service_name

  app_task_name = local.app_task_name

  application_load_balancer_name = local.application_load_balancer_name
  availability_zones             = module.vpc.azs
  aws_region                     = local.aws_region
  aws_cloudwatch_log_group       = local.aws_cloudwatch_log_group

  container_port          = local.container_port
  ecs_task_execution_role = local.ecs_task_execution_role_name
  ecr_repo_url            = module.ecrRepo.repository_url
  ecr_repo_name           = local.ecr_repo_name
  ecs_app_task_family     = local.ecs_app_task_family
  target_group_name       = local.target_group_name

  ecs_s3_bucket_name = module.s3.ecs_s3_bucket_name
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

module "s3" {
  source                 = "./modules/s3"
  ecs_assume_role_policy = module.ecs.ecr_viewer_and_s3_assume_role_policy
}
