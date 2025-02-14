data "aws_rds_engine_version" "postgresql" {
  engine             = local.postgresql_engine
  preferred_versions = [local.postgresql_engine_version]
}

resource "aws_db_instance" "postgresql" {
  count                           = var.database_type == "postgresql" ? 1 : 0
  allocated_storage               = "20"
  db_name                         = "ecr_viewer_db"
  identifier                      = local.vpc_name
  engine                          = data.aws_rds_engine_version.postgresql.engine
  engine_version                  = data.aws_rds_engine_version.postgresql.version_actual
  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]
  instance_class                  = local.postgresql_instance_class
  username                        = "postgres"
  password                        = random_password.database.result
  parameter_group_name            = aws_db_parameter_group.postgresql[0].name
  skip_final_snapshot             = true
  db_subnet_group_name            = aws_db_subnet_group.this.name
  vpc_security_group_ids          = [aws_security_group.postgresql.id]
  depends_on                      = [aws_secretsmanager_secret.postgresql_connection_string]
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

  # Allow inbound traffic on port 5432 for PostgreSQL from within the VPC
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [var.cidr]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.cidr]
  }
  tags = var.tags
}

resource "aws_secretsmanager_secret" "postgresql_connection_string" {
  count       = var.database_type == "postgresql" ? 1 : 0
  name        = "${local.vpc_name}-postgresql-connection-string-${random_string.secret_ident[0].result}"
  description = "Postgresql connection string for the ecr-viewer"
}

resource "aws_secretsmanager_secret_version" "postgresql" {
  count         = var.database_type == "postgresql" ? 1 : 0
  secret_id     = aws_secretsmanager_secret.postgresql_connection_string[0].id
  secret_string = "postgres://${aws_db_instance.postgresql[0].username}:${random_password.database.result}@${aws_db_instance.postgresql[0].address}:${aws_db_instance.postgresql[0].port}/${aws_db_instance.postgresql[0].db_name}"
}
