module "vpc" {
  source                      = "terraform-aws-modules/vpc/aws"
  name                        = local.vpc
  default_security_group_name = local.ecs_alb_sg
  cidr                        = var.vpc_cidr
  azs                         = var.availability_zones
  private_subnets             = var.private_subnets
  public_subnets              = var.public_subnets
  enable_nat_gateway          = var.enable_nat_gateway
  single_nat_gateway          = var.single_nat_gateway
}

module "iam" {
  source                  = "../../modules/iam"
  ecs_task_execution_role_name = local.ecs_task_execution_role_name
}

module "ecrRepo" {
  source                  = "../../modules/ecr"
  ecs_task_execution_role = module.iam.ecs_task_execution_role.arn
  ecr_repos               = local.ecr_repos
  ghcr_token              = local.ghcr_token
  ghcr_username           = local.ghcr_username
}

module "s3" {
  source                 = "../../modules/s3"
  ecs_assume_role_policy = module.iam.ecr_viewer_and_s3_assume_role_policy
}

module "ecs" {
  source                      = "../../modules/ecs"
  public_subnet_ids           = flatten(module.vpc.public_subnets)
  private_subnet_ids          = flatten(module.vpc.private_subnets)
  vpc_id                      = module.vpc.vpc_id
  cidr                        = module.vpc.vpc_cidr_block
  availability_zones          = module.vpc.azs
  ecs_task_execution_role_arn = module.iam.ecs_task_execution_role.arn
  ecr_repo_url                = module.ecrRepo.repository_url
  ecs_s3_bucket_name          = module.s3.ecs_s3_bucket_name
  app_service_name            = local.ecs_app_service_name
  app_task_name               = local.ecs_app_task_name
  alb_name                    = local.ecs_alb_name
  aws_cloudwatch_log_group    = local.ecs_cloudwatch_log_group
  container_port              = local.ecs_container_port
  ecr_repos                   = local.ecr_repos
  ecs_app_task_family         = local.ecs_app_task_family
  target_group_name           = local.ecs_target_group_name
  retention_in_days           = var.cw_retention_in_days
  aws_region                  = var.region
}
