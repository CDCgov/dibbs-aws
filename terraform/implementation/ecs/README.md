<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | =5.56.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.56.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ecs"></a> [ecs](#module\_ecs) | ../../modules/ecs | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/5.56.1/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | The availability zones to use | `list(string)` | <pre>[<br/>  "us-east-1a",<br/>  "us-east-1b",<br/>  "us-east-1c"<br/>]</pre> | no |
| <a name="input_create_internet_gateway"></a> [create\_internet\_gateway](#input\_create\_internet\_gateway) | Flag to determine if an internet gateway should be created | `bool` | `false` | no |
| <a name="input_ecr_viewer_database_schema"></a> [ecr\_viewer\_database\_schema](#input\_ecr\_viewer\_database\_schema) | The database schema used for the eCR data tables | `string` | `"core"` | no |
| <a name="input_ecr_viewer_database_type"></a> [ecr\_viewer\_database\_type](#input\_ecr\_viewer\_database\_type) | The SQL variant used for the eCR data tables | `string` | `"postgres"` | no |
| <a name="input_ecs_alb_sg"></a> [ecs\_alb\_sg](#input\_ecs\_alb\_sg) | The security group for the Application Load Balancer | `string` | `"ecs-albsg"` | no |
| <a name="input_enable_nat_gateway"></a> [enable\_nat\_gateway](#input\_enable\_nat\_gateway) | Enable NAT Gateway | `bool` | `false` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | The owner of the infrastructure | `string` | `"skylight"` | no |
| <a name="input_phdi_version"></a> [phdi\_version](#input\_phdi\_version) | PHDI container image version | `string` | `"v1.4.4"` | no |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | The private subnets | `list(string)` | <pre>[<br/>  "176.24.1.0/24",<br/>  "176.24.3.0/24"<br/>]</pre> | no |
| <a name="input_project"></a> [project](#input\_project) | The project name | `string` | `"dibbs-ce"` | no |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | The public subnets | `list(string)` | <pre>[<br/>  "176.24.2.0/24",<br/>  "176.24.4.0/24"<br/>]</pre> | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | `"us-east-1"` | no |
| <a name="input_single_nat_gateway"></a> [single\_nat\_gateway](#input\_single\_nat\_gateway) | Single NAT Gateway | `bool` | `false` | no |
| <a name="input_vpc"></a> [vpc](#input\_vpc) | The name of the VPC | `string` | `"ecs-vpc"` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | The CIDR block for the VPC | `string` | `"176.24.0.0/16"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->