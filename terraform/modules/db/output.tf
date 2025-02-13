output "secrets_manager_postgresql_connection_string_name" {
  value = var.database_type == "postgresql" ? aws_secretsmanager_secret.postgresql_connection_string[0].name : ""
}

output "secrets_manager_sqlserver_user_name" {
  value = var.database_type == "sqlserver" ? aws_secretsmanager_secret.sqlserver_user[0].name : ""
}

output "secrets_manager_sqlserver_password_name" {
  value = var.database_type == "sqlserver" ? aws_secretsmanager_secret.sqlserver_password[0].name : ""
}

output "secrets_manager_sqlserver_host_name" {
  value = var.database_type == "sqlserver" ? aws_secretsmanager_secret.sqlserver_host[0].name : ""
}
