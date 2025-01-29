resource "random_password" "database" {
  length = 13 #update as needed

  # Character set that excludes problematic characters like quotes, backslashes, etc.
  override_special = "[]{}"
}

# Create a DB subnet group
resource "aws_db_subnet_group" "this" {
  name       = "${local.vpc_name}-db-subnet-group-${terraform.workspace}"
  subnet_ids = var.private_subnet_ids
}
