locals {
  policy = var.lifecycle_policy == "" ? file("${path.module}/ecr-lifecycle-policy.json") : var.lifecycle_policy
  tags = {
    Automation = "Terraform"
  }
}
