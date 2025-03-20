<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.9.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.86.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.86.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_db"></a> [db](#module\_db) | ../../modules/db | n/a |
| <a name="module_ecs"></a> [ecs](#module\_ecs) | CDCgov/dibbs-ecr-viewer/aws | 0.5.0 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | 5.16.0 |

## Resources

| Name | Type |
|------|------|
| [aws_route.route_private_ecr_viewer_to_rhapsody](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.route_public_ecr_viewer_to_rhapsody](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.route_rhapsody_to_ecr_viewer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route53_record.alb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_vpc_peering_connection.peer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection) | resource |
| [aws_acm_certificate.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/acm_certificate) | data source |
| [aws_vpc.rhapsody](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |
| [aws_vpcs.rhapsody](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpcs) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auth_client_id"></a> [auth\_client\_id](#input\_auth\_client\_id) | The application/client id used to idenitfy the client | `string` | `""` | no |
| <a name="input_auth_issuer"></a> [auth\_issuer](#input\_auth\_issuer) | Additional information used during authentication process. For Azure AD, this will be the 'Tenant Id'. For Keycloak, this will be the url issuer including the realm - e.g. https://my-keycloak-domain.com/realms/My_Realm | `string` | `""` | no |
| <a name="input_auth_provider"></a> [auth\_provider](#input\_auth\_provider) | The authentication provider used. Either keycloak or ad. | `string` | `""` | no |
| <a name="input_auth_url"></a> [auth\_url](#input\_auth\_url) | Optional. The full URL of the auth api. By default https://your-site.com/ecr-viewer/api/auth. | `string` | `""` | no |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | The availability zones to use | `list(string)` | <pre>[<br>  "us-east-1a",<br>  "us-east-1b",<br>  "us-east-1c"<br>]</pre> | no |
| <a name="input_database_type"></a> [database\_type](#input\_database\_type) | The type of database to use (postgresql or sqlserver) | `string` | `"postgresql"` | no |
| <a name="input_dibbs_config_name"></a> [dibbs\_config\_name](#input\_dibbs\_config\_name) | The name of the DIBBS configuration | `string` | `"AWS_PG_NON_INTEGRATED"` | no |
| <a name="input_internal"></a> [internal](#input\_internal) | Flag to determine if the several AWS resources are public (intended for external access, public internet) or private (only intended to be accessed within your AWS VPC or avaiable with other means, a transit gateway for example). | `bool` | `false` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | The owner of the infrastructure | `string` | `"skylight"` | no |
| <a name="input_phdi_version"></a> [phdi\_version](#input\_phdi\_version) | PHDI container image version | `string` | `"3.0.0-Beta"` | no |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | The private subnets | `list(string)` | <pre>[<br>  "176.24.1.0/24",<br>  "176.24.3.0/24"<br>]</pre> | no |
| <a name="input_project"></a> [project](#input\_project) | The project name | `string` | `"dibbs"` | no |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | The public subnets | `list(string)` | <pre>[<br>  "176.24.2.0/24",<br>  "176.24.4.0/24"<br>]</pre> | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | `"us-east-1"` | no |
| <a name="input_route53_hosted_zone_id"></a> [route53\_hosted\_zone\_id](#input\_route53\_hosted\_zone\_id) | The Route53 hosted zone ID | `string` | `""` | no |
| <a name="input_secrets_manager_auth_client_secret_version"></a> [secrets\_manager\_auth\_client\_secret\_version](#input\_secrets\_manager\_auth\_client\_secret\_version) | The secret containing the auth client secret. This is the secret that comes from the authentication provider. | `string` | `""` | no |
| <a name="input_secrets_manager_auth_secret_version"></a> [secrets\_manager\_auth\_secret\_version](#input\_secrets\_manager\_auth\_secret\_version) | The secret containing the auth secret. This is used by eCR viewer to encrypt authentication. This can be generated by running `openssl rand -base64 32`. | `string` | `""` | no |
| <a name="input_ssh_key_name"></a> [ssh\_key\_name](#input\_ssh\_key\_name) | The name of the SSH key to use for the instances | `string` | `""` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | The CIDR block for the VPC | `string` | `"176.24.0.0/16"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->