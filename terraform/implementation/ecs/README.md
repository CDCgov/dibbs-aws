<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | =5.56.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.56.1 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.6.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ecr"></a> [ecr](#module\_ecr) | ../../modules/ecr | n/a |
| <a name="module_ecs"></a> [ecs](#module\_ecs) | ../../modules/ecs | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | n/a |

## Resources

| Name | Type |
|------|------|
| [random_string.s3_viewer](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/5.56.1/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_internal"></a> [alb\_internal](#input\_alb\_internal) | Whether the ALB is public or private | `bool` | `true` | no |
| <a name="input_appmesh_name"></a> [appmesh\_name](#input\_appmesh\_name) | The name of the App Mesh | `string` | `"appmesh"` | no |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | The availability zones to use | `list(string)` | <pre>[<br>  "us-east-1a",<br>  "us-east-1b",<br>  "us-east-1c"<br>]</pre> | no |
| <a name="input_cloudmap_namespace_name"></a> [cloudmap\_namespace\_name](#input\_cloudmap\_namespace\_name) | The name of the CloudMap namespace | `string` | `"cloudmap-service-connect"` | no |
| <a name="input_cloudmap_service_name"></a> [cloudmap\_service\_name](#input\_cloudmap\_service\_name) | The name of the CloudMap service | `string` | `"cloudmap-services"` | no |
| <a name="input_cw_retention_in_days"></a> [cw\_retention\_in\_days](#input\_cw\_retention\_in\_days) | The number of days to retain logs in CloudWatch | `number` | `30` | no |
| <a name="input_ecs_alb_name"></a> [ecs\_alb\_name](#input\_ecs\_alb\_name) | The name of the Application Load Balancer | `string` | `"ecs-alb"` | no |
| <a name="input_ecs_alb_sg"></a> [ecs\_alb\_sg](#input\_ecs\_alb\_sg) | The security group for the Application Load Balancer | `string` | `"ecs-albsg"` | no |
| <a name="input_ecs_cloudwatch_group"></a> [ecs\_cloudwatch\_group](#input\_ecs\_cloudwatch\_group) | The name of the CloudWatch log group | `string` | `"ecs-cwlg"` | no |
| <a name="input_ecs_cluster_name"></a> [ecs\_cluster\_name](#input\_ecs\_cluster\_name) | The name of the ECS cluster | `string` | `"ecs-cluster"` | no |
| <a name="input_ecs_task_execution_role_name"></a> [ecs\_task\_execution\_role\_name](#input\_ecs\_task\_execution\_role\_name) | The name of the ECS task execution role | `string` | `"ecs-tern"` | no |
| <a name="input_ecs_task_role_name"></a> [ecs\_task\_role\_name](#input\_ecs\_task\_role\_name) | The name of the ECS task role | `string` | `"ecs-tr"` | no |
| <a name="input_enable_nat_gateway"></a> [enable\_nat\_gateway](#input\_enable\_nat\_gateway) | Enable NAT Gateway | `bool` | `true` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | The owner of the infrastructure | `string` | `"skylight"` | no |
| <a name="input_phdi_version"></a> [phdi\_version](#input\_phdi\_version) | PHDI container image version | `string` | `"v1.4.4"` | no |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | The private subnets | `list(string)` | <pre>[<br>  "176.24.1.0/24",<br>  "176.24.3.0/24"<br>]</pre> | no |
| <a name="input_project"></a> [project](#input\_project) | The project name | `string` | `"dibbs-ce"` | no |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | The public subnets | `list(string)` | <pre>[<br>  "176.24.2.0/24",<br>  "176.24.4.0/24"<br>]</pre> | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | `"us-east-1"` | no |
| <a name="input_s3_viewer_bucket_name"></a> [s3\_viewer\_bucket\_name](#input\_s3\_viewer\_bucket\_name) | The name of the viewer bucket | `string` | `"s3-viewer"` | no |
| <a name="input_s3_viewer_bucket_role_name"></a> [s3\_viewer\_bucket\_role\_name](#input\_s3\_viewer\_bucket\_role\_name) | The role for the ecr-viewer bucket | `string` | `"s3-viewer-role"` | no |
| <a name="input_single_nat_gateway"></a> [single\_nat\_gateway](#input\_single\_nat\_gateway) | Single NAT Gateway | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to resources | `map(string)` | `{}` | no |
| <a name="input_vpc"></a> [vpc](#input\_vpc) | The name of the VPC | `string` | `"ecs-vpc"` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | The CIDR block for the VPC | `string` | `"176.24.0.0/16"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->