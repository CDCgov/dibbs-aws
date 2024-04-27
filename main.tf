module "ecrRepo" {
    source = "./modules/ecr"

    ecr_repo_name = local.ecr_repo_name
}

module "ecs" {
    source = "./modules/ecs"

    retention_in_days = local.retention_in_days
}