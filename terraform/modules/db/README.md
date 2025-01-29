<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.9.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | =5.56.1 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.6.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | =5.56.1 |
| <a name="provider_random"></a> [random](#provider\_random) | ~> 3.6.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_db_instance.postgresql](https://registry.terraform.io/providers/hashicorp/aws/5.56.1/docs/resources/db_instance) | resource |
| [aws_db_instance.sqlserver](https://registry.terraform.io/providers/hashicorp/aws/5.56.1/docs/resources/db_instance) | resource |
| [aws_db_parameter_group.postgresql](https://registry.terraform.io/providers/hashicorp/aws/5.56.1/docs/resources/db_parameter_group) | resource |
| [aws_db_parameter_group.sqlserver](https://registry.terraform.io/providers/hashicorp/aws/5.56.1/docs/resources/db_parameter_group) | resource |
| [aws_db_subnet_group.this](https://registry.terraform.io/providers/hashicorp/aws/5.56.1/docs/resources/db_subnet_group) | resource |
| [aws_secretsmanager_secret.postgresql_connection_string](https://registry.terraform.io/providers/hashicorp/aws/5.56.1/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret.sqlserver_host](https://registry.terraform.io/providers/hashicorp/aws/5.56.1/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret.sqlserver_password](https://registry.terraform.io/providers/hashicorp/aws/5.56.1/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret.sqlserver_user](https://registry.terraform.io/providers/hashicorp/aws/5.56.1/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.postgresql](https://registry.terraform.io/providers/hashicorp/aws/5.56.1/docs/resources/secretsmanager_secret_version) | resource |
| [aws_secretsmanager_secret_version.sqlserver_host](https://registry.terraform.io/providers/hashicorp/aws/5.56.1/docs/resources/secretsmanager_secret_version) | resource |
| [aws_secretsmanager_secret_version.sqlserver_password](https://registry.terraform.io/providers/hashicorp/aws/5.56.1/docs/resources/secretsmanager_secret_version) | resource |
| [aws_secretsmanager_secret_version.sqlserver_user](https://registry.terraform.io/providers/hashicorp/aws/5.56.1/docs/resources/secretsmanager_secret_version) | resource |
| [aws_security_group.postgresql](https://registry.terraform.io/providers/hashicorp/aws/5.56.1/docs/resources/security_group) | resource |
| [aws_security_group.sqlserver](https://registry.terraform.io/providers/hashicorp/aws/5.56.1/docs/resources/security_group) | resource |
| [random_password.database](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [aws_rds_engine_version.postgresql](https://registry.terraform.io/providers/hashicorp/aws/5.56.1/docs/data-sources/rds_engine_version) | data source |
| [aws_rds_engine_version.sqlserver](https://registry.terraform.io/providers/hashicorp/aws/5.56.1/docs/data-sources/rds_engine_version) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr"></a> [cidr](#input\_cidr) | The CIDR block for the VPC | `string` | `""` | no |
| <a name="input_database_type"></a> [database\_type](#input\_database\_type) | The type of database to use (postgresql or sqlserver) | `string` | `""` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | The owner of the infrastructure | `string` | `"skylight"` | no |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | List of private subnet IDs | `list(string)` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | The project name | `string` | `"dibbs"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to resources | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the VPC | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->