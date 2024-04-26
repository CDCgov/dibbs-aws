module "ecrRepo" {
    source = "./modules/ecr"

    ecr_repo_name = local.ecr_repo_name
}