data "aws_rds_engine_version" "postgresql" {
  engine  = local.postgresql_engine
  version = local.postgresql_engine_major_version
  latest  = true
}

resource "aws_db_instance" "postgresql" {
  # checkov:skip=CKV_AWS_293: Deletion protection: ignore for non-production environments
  # checkov:skip=CKV_AWS_354: KMS key: TODO
  # checkov:skip=CKV_AWS_157: Multi-region: TODO
  count                               = var.database_type == "postgresql" ? 1 : 0
  iam_database_authentication_enabled = true
  allocated_storage                   = "20"
  db_name                             = "ecr_viewer_db"
  identifier                          = local.vpc_name
  engine                              = data.aws_rds_engine_version.postgresql.engine
  engine_version                      = data.aws_rds_engine_version.postgresql.version_actual
  enabled_cloudwatch_logs_exports     = ["postgresql", "upgrade"]
  instance_class                      = local.postgresql_instance_class
  username                            = "postgres"
  password                            = random_password.database.result
  parameter_group_name                = aws_db_parameter_group.postgresql[0].name
  skip_final_snapshot                 = true
  db_subnet_group_name                = aws_db_subnet_group.this.name
  vpc_security_group_ids              = [aws_security_group.postgresql.id]
  depends_on                          = [aws_secretsmanager_secret.postgresql_connection_string]
  copy_tags_to_snapshot               = true
  storage_encrypted                   = true
  monitoring_interval                 = 0
  performance_insights_enabled        = true
  auto_minor_version_upgrade          = true
}

# Create a parameter group to configure Postgres RDS parameters
resource "aws_db_parameter_group" "postgresql" {
  count  = var.database_type == "postgresql" ? 1 : 0
  name   = "${local.vpc_name}-postgresql"
  family = data.aws_rds_engine_version.postgresql.parameter_group_family

  parameter {
    name  = "log_connections"
    value = "1"
  }
  parameter {
    name  = "rds.force_ssl"
    value = "0"
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "postgresql" {
  vpc_id = var.vpc_id

  # PostgreSQL database security group for port 5432 access within VPC
  description = "PostgreSQL database security group for port 5432 access within VPC"

  # Allow inbound traffic on port 5432 for PostgreSQL from within the VPC
  ingress {
    description = "Allow PostgreSQL access from within VPC"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [var.cidr]
  }

  # Allow all outbound traffic
  egress {
    description = "Allow all outbound traffic from the security group"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.cidr]
  }
  tags = var.tags
}

resource "aws_secretsmanager_secret" "postgresql_connection_string" {
  # checkov:skip=CKV_AWS_57: Secret rotation: TODO
  # checkov:skip=CKV2_AWS_57: Secret rotation: TODO
  # checkov:skip=CKV_AWS_149: KMS key: TODO
  count       = var.database_type == "postgresql" ? 1 : 0
  name        = "${local.vpc_name}-postgresql-connection-string-${random_string.secret_ident[0].result}"
  description = "Postgresql connection string for the ecr-viewer"
  tags        = var.tags
}

resource "aws_secretsmanager_secret_version" "postgresql" {
  count         = var.database_type == "postgresql" ? 1 : 0
  secret_id     = aws_secretsmanager_secret.postgresql_connection_string[0].id
  secret_string = "postgres://${aws_db_instance.postgresql[0].username}:${random_password.database.result}@${aws_db_instance.postgresql[0].address}:${aws_db_instance.postgresql[0].port}/${aws_db_instance.postgresql[0].db_name}"
}
