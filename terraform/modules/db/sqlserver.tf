data "aws_rds_engine_version" "sqlserver" {
  engine             = local.sqlserver_engine
  preferred_versions = [local.sqlserver_engine_version]
}

resource "aws_db_instance" "sqlserver" {
  count                           = var.database_type == "sqlserver" ? 1 : 0
  allocated_storage               = "20"
  identifier                      = "${local.vpc_name}-${var.database_type}-ecr-viewer"
  engine                          = data.aws_rds_engine_version.sqlserver.engine
  engine_version                  = data.aws_rds_engine_version.sqlserver.version_actual
  enabled_cloudwatch_logs_exports = []
  instance_class                  = local.sqlserver_instance_class
  username                        = "sa"
  password                        = random_password.database.result
  parameter_group_name            = aws_db_parameter_group.sqlserver[0].name
  skip_final_snapshot             = true
  db_subnet_group_name            = aws_db_subnet_group.this.name
  vpc_security_group_ids          = [aws_security_group.sqlserver.id]
  license_model                   = "license-included"
  tags                            = var.tags
}

# Create a parameter group to configure SqlServer RDS parameters
resource "aws_db_parameter_group" "sqlserver" {
  count  = var.database_type == "sqlserver" ? 1 : 0
  name   = "${local.vpc_name}-sqlserver"
  family = data.aws_rds_engine_version.sqlserver.parameter_group_family

  parameter {
    name  = "rds.force_ssl"
    value = "0"
  }
}

resource "aws_security_group" "sqlserver" {
  vpc_id = var.vpc_id

  # Allow inbound traffic on port 1433 for SqlServer from within the VPC
  ingress {
    from_port   = 1433
    to_port     = 1433
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

resource "aws_secretsmanager_secret" "sqlserver_connection_string" {
  count       = var.database_type == "sqlserver" ? 1 : 0
  name        = "${local.vpc_name}-sqlserver-connection-string-${random_string.secret_ident[0].result}"
  description = "SqlServer connection string for the ecr-viewer"
  tags        = var.tags
}

resource "aws_secretsmanager_secret_version" "sqlserver" {
  count     = var.database_type == "sqlserver" ? 1 : 0
  secret_id = aws_secretsmanager_secret.sqlserver_connection_string[0].id
  secret_string = jsonencode({
    connection_string = "Server=${aws_db_instance.sqlserver[0].endpoint};Database=${aws_db_instance.sqlserver[0].db_name};User Id=${aws_db_instance.sqlserver[0].username};Password=${aws_db_instance.sqlserver[0].password};"
  })
}
