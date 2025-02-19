output "secrets_manager_postgresql_connection_string_version" {
  value     = var.database_type == "postgresql" ? aws_secretsmanager_secret_version.postgresql[0].secret_string : ""
  sensitive = true
}

output "secrets_manager_sqlserver_user_version" {
  value     = var.database_type == "sqlserver" ? aws_secretsmanager_secret_version.sqlserver_user[0].secret_string : ""
  sensitive = true
}

output "secrets_manager_sqlserver_password_version" {
  value     = var.database_type == "sqlserver" ? aws_secretsmanager_secret_version.sqlserver_password[0].secret_string : ""
  sensitive = true
}

output "secrets_manager_sqlserver_host_version" {
  value     = var.database_type == "sqlserver" ? aws_secretsmanager_secret_version.sqlserver_host[0].secret_string : ""
  sensitive = true
}