module "ecr" {
  source = "../../modules/ecr"

  region       = var.region
  service_data = local.service_data
}