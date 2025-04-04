resource "random_string" "setup" {
  length  = 8
  special = false
  upper   = false
}

module "tfstate" {
  source     = "../../modules/tfstate"
  identifier = random_string.setup.result
  owner      = var.owner
  project    = var.project
}


# GitHub OIDC for dev
module "oidc_dev" {
  source = "../../modules/oidc"

  # The github repo that will be used for OIDC
  oidc_github_repo = var.oidc_github_repo

  # These variables must match the values that you'll be using for your ECS module call in the /ecs module
  region  = var.region
  owner   = var.owner
  project = var.project

  # resource_tag_to_match can be "owner", "project", or "workspace"
  resource_tag_to_match = "owner"

  # If resource_tag_to_match is "workspace", then this variable must match the name of the terraform workspace that you'll be using for your ECS module call in the /ecs module
  workspace = "dev"

  # state_bucket_arn   = module.tfstate.aws_s3_bucket.tfstate.arn
  state_bucket_arn = module.tfstate.state_bucket.arn
  # dynamodb_table_arn = aws_dynamodb_table.tfstate_lock.arn
  dynamodb_table_arn = module.tfstate.dynamodb_table.arn
}

# GitHub OIDC for prod
module "oidc_prod" {
  source = "../../modules/oidc"

  # The github repo that will be used for OIDC
  oidc_github_repo = var.oidc_github_repo

  # These variables must match the values that you'll be using for your ECS module call in the /ecs module
  region  = var.region
  owner   = var.owner
  project = var.project

  # resource_tag_to_match can be "owner", "project", or "workspace"
  resource_tag_to_match = "owner"

  # If resource_tag_to_match is "workspace", then this variable must exactly match the name of the terraform workspace that you'll be using for your ECS module call in the /ecs module
  workspace = "prod"

  # state_bucket_arn   = module.tfstate.aws_s3_bucket.tfstate.arn
  state_bucket_arn = module.tfstate.state_bucket.arn
  # dynamodb_table_arn = aws_dynamodb_table.tfstate_lock.arn
  dynamodb_table_arn = module.tfstate.dynamodb_table.arn
}

resource "local_file" "setup_env" {
  content  = <<-EOT
    WORKSPACE="${terraform.workspace}"
    BUCKET="${module.tfstate.state_bucket.bucket}"
    DYNAMODB_TABLE="${module.tfstate.dynamodb_table.arn}"
    REGION="${var.region}"
    TERRAFORM_ROLES="${module.oidc_dev.role.arn} ${module.oidc_prod.role.arn}"
  EOT
  filename = ".env"
}