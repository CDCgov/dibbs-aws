module "vpc" {
  source                      = "terraform-aws-modules/vpc/aws"
  name                        = local.vpc_name
  default_security_group_name = local.ecs_alb_sg
  cidr                        = var.vpc_cidr
  azs                         = var.availability_zones
  private_subnets             = var.private_subnets
  public_subnets              = var.public_subnets
  enable_nat_gateway          = var.enable_nat_gateway
  single_nat_gateway          = var.single_nat_gateway
}

module "iam" {
  source                       = "../../modules/iam"
  ecs_task_execution_role_name = local.ecs_task_execution_role_name
  ecs_cluster_name             = local.ecs_cluster_name
  aws_caller_identity          = data.aws_caller_identity.current.account_id
  region                       = var.region
  ecs_ecr_policy_name          = local.ecs_ecr_policy_name
  ecs_cloudwatch_policy_name   = local.ecs_cloudwatch_policy_name
  ecs_cloudwatch_role_name     = local.ecs_cloudwatch_role_name
}

module "ecr" {
  source                  = "../../modules/ecr"
  aws_caller_identity     = data.aws_caller_identity.current.account_id
  ecs_task_execution_role = module.iam.ecs_task_execution_role.arn
  service_data            = local.service_data
  phdi_version            = var.phdi_version
  region                  = var.region
}

module "s3" {
  source                       = "../../modules/s3"
  ecs_assume_role_policy       = module.iam.ecr_viewer_and_s3_assume_role_policy
  region                       = var.region
  s3_viewer_bucket_name        = local.s3_viewer_bucket_name
  s3_viewer_bucket_role_name   = local.s3_viewer_bucket_role_name
  s3_viewer_bucket_policy_name = local.s3_viewer_bucket_policy_name
}

module "ecs" {
  source                      = "../../modules/ecs"
  public_subnet_ids           = flatten(module.vpc.public_subnets)
  private_subnet_ids          = flatten(module.vpc.private_subnets)
  vpc_id                      = module.vpc.vpc_id
  availability_zones          = module.vpc.azs
  ecs_task_execution_role_arn = module.iam.ecs_task_execution_role.arn
  ecs_cluster_name            = local.ecs_cluster_name
  ecs_alb_name                = local.ecs_alb_name
  ecs_alb_tg_name             = local.ecs_alb_tg_name
  ecs_cloudwatch_group        = local.ecs_cloudwatch_group
  service_data                = local.service_data
  cw_retention_in_days        = var.cw_retention_in_days
  region                      = var.region
  cloudmap_namespace_name     = local.cloudmap_namespace_name
  cloudmap_service_name       = local.cloudmap_service_name
  appmesh_name                = local.appmesh_name
}
