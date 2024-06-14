locals {
  # Use our standard lifecycle policy if none passed in.
  images = {
    "fhir-converter" = "${var.aws_caller_identity}.dkr.${var.region}.amazonaws.com/fhir-converter"
    "ingestion"      = "${var.aws_caller_identity}.dkr.${var.region}.amazonaws.com/ingestion"
    "message-parser" = "${var.aws_caller_identity}.dkr.ecr.${var.region}.amazonaws.com/message-parser"
    "orchestration"  = "${var.aws_caller_identity}.dkr.ecr.${var.region}.amazonaws.com/orchestration"
  }

  policy = var.lifecycle_policy == "" ? file("${path.module}/ecr-lifecycle-policy.json") : var.lifecycle_policy

  repo_name = var.ecr_repos
  tags = {
    Automation = "Terraform"
  }

  # NOTE: The version may need to be changed with updates
  phdi_version = "v1.4.4"


}
