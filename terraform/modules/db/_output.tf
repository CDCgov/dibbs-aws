output "secrets_manager_database_connection_string_version" {
  value     = var.database_type == "postgresql" ? aws_secretsmanager_secret_version.postgresql[0].secret_string : var.database_type == "sqlserver" ? aws_secretsmanager_secret_version.sqlserver_connection_string[0].secret_string : ""
  sensitive = true
}
