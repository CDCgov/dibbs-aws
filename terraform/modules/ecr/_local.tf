locals {
  policy = var.lifecycle_policy == "" ? file("${path.module}/ecr-lifecycle-policy.json") : var.lifecycle_policy
  repo_name = var.ecr_repo_names
  tags = {
    Automation = "Terraform"
  }
  # NOTE: The version may need to be changed with updates
  phdi_version = "v1.4.4"
}
