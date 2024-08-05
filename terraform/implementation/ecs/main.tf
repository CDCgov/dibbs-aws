module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name                        = local.vpc_name
  default_security_group_name = local.ecs_alb_sg
  cidr                        = var.vpc_cidr
  azs                         = var.availability_zones
  private_subnets             = var.private_subnets
  public_subnets              = var.public_subnets
  enable_nat_gateway          = var.enable_nat_gateway
  single_nat_gateway          = var.single_nat_gateway
}

module "ecr" {
  source = "../../modules/ecr"

  region       = var.region
  service_data = local.service_data
}

module "ecs" {
  source = "../../modules/ecs"

  appmesh_name                 = local.appmesh_name
  cloudmap_namespace_name      = local.cloudmap_namespace_name
  cloudmap_service_name        = local.cloudmap_service_name
  ecs_task_execution_role_name = local.ecs_task_execution_role_name
  ecs_task_role_name           = local.ecs_task_role_name
  ecs_cluster_name             = local.ecs_cluster_name
  ecs_alb_name                 = local.ecs_alb_name
  ecs_alb_tg_name              = local.ecs_alb_tg_name
  ecs_cloudwatch_group         = local.ecs_cloudwatch_group
  s3_viewer_bucket_name        = local.s3_viewer_bucket_name
  s3_viewer_bucket_role_name   = local.s3_viewer_bucket_role_name
  service_data                 = local.service_data

  public_subnet_ids  = flatten(module.vpc.public_subnets)
  private_subnet_ids = flatten(module.vpc.private_subnets)
  vpc_id             = module.vpc.vpc_id

  alb_internal         = var.alb_internal
  cw_retention_in_days = var.cw_retention_in_days
  region               = var.region
}
