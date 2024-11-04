<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_dockerless"></a> [dockerless](#requirement\_dockerless) | 0.1.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_dockerless"></a> [dockerless](#provider\_dockerless) | 0.1.1 |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_alb.ecs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb) | resource |
| [aws_alb_listener.http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_listener) | resource |
| [aws_alb_listener_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_listener_rule) | resource |
| [aws_alb_target_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_target_group) | resource |
| [aws_appmesh_mesh.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appmesh_mesh) | resource |
| [aws_appmesh_virtual_node.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appmesh_virtual_node) | resource |
| [aws_cloudwatch_log_group.ecs_cloudwatch_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_ecr_repository.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |
| [aws_ecs_cluster.dibbs_app_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster) | resource |
| [aws_ecs_service.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_flow_log.ecs_flow_log](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/flow_log) | resource |
| [aws_iam_policy.s3_bucket_ecr_viewer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.ecs_task](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.ecs_task_execution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.s3_role_for_ecr_viewer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_s3_bucket.ecr_viewer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_public_access_block.ecr_viewer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.ecr_viewer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.ecr_viewer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_security_group.alb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.ecs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.alb_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.alb_http_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.alb_https_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ecs_alb_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ecs_all_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ecs_ecs_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_service_discovery_private_dns_namespace.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/service_discovery_private_dns_namespace) | resource |
| [aws_vpc_endpoint.endpoints](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [dockerless_remote_image.dibbs](https://registry.terraform.io/providers/nullstone-io/dockerless/0.1.1/docs/resources/remote_image) | resource |
| [null_resource.target_groups](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [random_string.s3_viewer](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_ecr_authorization_token.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ecr_authorization_token) | data source |
| [aws_iam_policy.amazon_ec2_container_service_for_ec2_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy.ecs_task_execution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ecr_viewer_s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_route_table.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route_table) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_appmesh_name"></a> [appmesh\_name](#input\_appmesh\_name) | Name of the AWS App Mesh | `string` | `""` | no |
| <a name="input_cloudmap_namespace_name"></a> [cloudmap\_namespace\_name](#input\_cloudmap\_namespace\_name) | Name of the AWS Cloud Map namespace | `string` | `""` | no |
| <a name="input_cloudmap_service_name"></a> [cloudmap\_service\_name](#input\_cloudmap\_service\_name) | Name of the AWS Cloud Map service | `string` | `""` | no |
| <a name="input_cw_retention_in_days"></a> [cw\_retention\_in\_days](#input\_cw\_retention\_in\_days) | Retention period in days for CloudWatch logs | `number` | `30` | no |
| <a name="input_disable_ecr"></a> [disable\_ecr](#input\_disable\_ecr) | Flag to disable the aws ecr service for docker image storage, defaults to false | `bool` | `false` | no |
| <a name="input_ecr_viewer_app_env"></a> [ecr\_viewer\_app\_env](#input\_ecr\_viewer\_app\_env) | The current environment that is running. This may modify behavior of auth between dev and prod. | `string` | `"prod"` | no |
| <a name="input_ecr_viewer_auth_pub_key"></a> [ecr\_viewer\_auth\_pub\_key](#input\_ecr\_viewer\_auth\_pub\_key) | The public key used to validate the incoming authenication for the eCR Viewer. | `string` | `"-----BEGIN PUBLIC KEY-----\nMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAqjrH9PprQCB5dX15zYfd\nS6K2ezNi/ZOu8vKEhQuLqwHACy1iUt1Yyp2PZLIV7FVDgBHMMVWPVx3GJ2wEyaJw\nMHkv6XNpUpWLhbs0V1T7o/OZfEIqcNua07OEoBxX9vhKIHtaksWdoMyKRXQJz0js\noWpawfOWxETnLqGvybT4yvY2RJhquTXLcLu90L4LdvIkADIZshaOtAU/OwI5ATcb\nfE3ip15E6jIoUm7FAtfRiuncpI5l/LJPP6fvwf8QCbbUJBZklLqcUuf4qe/L/nIq\npIONb8KZFWPhnGeRZ9bwIcqYWt3LAAshQLSGEYl2PGXaqbkUD2XLETSKDjisxd0g\n9j8bIMPgBKi+dBYcmBZnR7DxJe+vEDDw8prHG/+HRy5fim/BcibTKnIl8PR5yqHa\nmWQo7N+xXhILdD9e33KLRgbg97+erHqvHlNMdwDhAfrBT+W6GCdPwp3cePPsbhsc\noGSHOUDhzyAujr0J8h5WmZDGUNWjGzWqubNZD8dBXB8x+9dDoWhfM82nw0pvAeKf\nwJodvn3Qo8/S5hxJ6HyGkUTANKN8IxWh/6R5biET5BuztZP6jfPEaOAnt6sq+C38\nhR9rUr59dP2BTlcJ19ZXobLwuJEa81S5BrcbDwYNOAzC8jl2EV1i4bQIwJJaY27X\nIynom6unaheZpS4DFIh2w9UCAwEAAQ==\n-----END PUBLIC KEY-----\n"` | no |
| <a name="input_ecr_viewer_basepath"></a> [ecr\_viewer\_basepath](#input\_ecr\_viewer\_basepath) | The basepath for the ecr-viewer | `string` | `"/ecr-viewer"` | no |
| <a name="input_ecs_alb_name"></a> [ecs\_alb\_name](#input\_ecs\_alb\_name) | Name of the Application Load Balancer (ALB) | `string` | `""` | no |
| <a name="input_ecs_alb_sg"></a> [ecs\_alb\_sg](#input\_ecs\_alb\_sg) | Name of the ECS ALB Security Group | `string` | `""` | no |
| <a name="input_ecs_alb_tg_name"></a> [ecs\_alb\_tg\_name](#input\_ecs\_alb\_tg\_name) | Name of the ALB Target Group | `string` | `""` | no |
| <a name="input_ecs_cloudwatch_group"></a> [ecs\_cloudwatch\_group](#input\_ecs\_cloudwatch\_group) | Name of the AWS CloudWatch Log Group for ECS | `string` | `""` | no |
| <a name="input_ecs_cluster_name"></a> [ecs\_cluster\_name](#input\_ecs\_cluster\_name) | Name of the ECS Cluster | `string` | `""` | no |
| <a name="input_ecs_task_execution_role_name"></a> [ecs\_task\_execution\_role\_name](#input\_ecs\_task\_execution\_role\_name) | Name of the ECS Task Execution Role | `string` | `""` | no |
| <a name="input_ecs_task_role_name"></a> [ecs\_task\_role\_name](#input\_ecs\_task\_role\_name) | Name of the ECS Task Role | `string` | `""` | no |
| <a name="input_internal"></a> [internal](#input\_internal) | Flag to determine if the several AWS resources are public (intended for external access, public internet) or private (only intended to be accessed within your AWS VPC or avaiable with other means, a transit gateway for example). | `bool` | `true` | no |
| <a name="input_non_integrated_viewer"></a> [non\_integrated\_viewer](#input\_non\_integrated\_viewer) | A flag to determine if the viewer is the non-integrated version | `string` | `"false"` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | Owner of the resources | `string` | `"CDC"` | no |
| <a name="input_phdi_version"></a> [phdi\_version](#input\_phdi\_version) | Version of the PHDI application | `string` | `"v1.6.9"` | no |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | List of private subnet IDs | `list(string)` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | The project name | `string` | `"dibbs"` | no |
| <a name="input_public_subnet_ids"></a> [public\_subnet\_ids](#input\_public\_subnet\_ids) | List of public subnet IDs | `list(string)` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The AWS region where resources are created | `string` | n/a | yes |
| <a name="input_s3_viewer_bucket_name"></a> [s3\_viewer\_bucket\_name](#input\_s3\_viewer\_bucket\_name) | Name of the S3 bucket for the viewer | `string` | `""` | no |
| <a name="input_s3_viewer_bucket_role_name"></a> [s3\_viewer\_bucket\_role\_name](#input\_s3\_viewer\_bucket\_role\_name) | Name of the IAM role for the ecr-viewer bucket | `string` | `""` | no |
| <a name="input_service_data"></a> [service\_data](#input\_service\_data) | Data for the DIBBS services | <pre>map(object({<br>    short_name     = string<br>    fargate_cpu    = number<br>    fargate_memory = number<br>    app_count      = number<br>    app_image      = string<br>    app_version    = string<br>    container_port = number<br>    host_port      = number<br>    public         = bool<br>    registry_url   = string<br>    env_vars = list(object({<br>      name  = string<br>      value = string<br>    }))<br>  }))</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to resources | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb_arn"></a> [alb\_arn](#output\_alb\_arn) | n/a |
| <a name="output_alb_listener_arn"></a> [alb\_listener\_arn](#output\_alb\_listener\_arn) | n/a |
| <a name="output_alb_listener_rules_arns"></a> [alb\_listener\_rules\_arns](#output\_alb\_listener\_rules\_arns) | n/a |
| <a name="output_alb_security_group_arn"></a> [alb\_security\_group\_arn](#output\_alb\_security\_group\_arn) | n/a |
| <a name="output_alb_target_groups_arns"></a> [alb\_target\_groups\_arns](#output\_alb\_target\_groups\_arns) | n/a |
| <a name="output_ecs_cluster_arn"></a> [ecs\_cluster\_arn](#output\_ecs\_cluster\_arn) | n/a |
| <a name="output_ecs_security_group_arn"></a> [ecs\_security\_group\_arn](#output\_ecs\_security\_group\_arn) | n/a |
| <a name="output_ecs_task_definitions_arns"></a> [ecs\_task\_definitions\_arns](#output\_ecs\_task\_definitions\_arns) | n/a |
| <a name="output_ecs_task_execution_role_arn"></a> [ecs\_task\_execution\_role\_arn](#output\_ecs\_task\_execution\_role\_arn) | n/a |
| <a name="output_ecs_task_role_arn"></a> [ecs\_task\_role\_arn](#output\_ecs\_task\_role\_arn) | n/a |
| <a name="output_s3_bucket_arn"></a> [s3\_bucket\_arn](#output\_s3\_bucket\_arn) | The ARN of the S3 bucket |
| <a name="output_s3_bucket_ecr_viewer_policy_arn"></a> [s3\_bucket\_ecr\_viewer\_policy\_arn](#output\_s3\_bucket\_ecr\_viewer\_policy\_arn) | n/a |
| <a name="output_s3_role_for_ecr_viewer_arn"></a> [s3\_role\_for\_ecr\_viewer\_arn](#output\_s3\_role\_for\_ecr\_viewer\_arn) | n/a |
| <a name="output_service_data"></a> [service\_data](#output\_service\_data) | n/a |
<!-- END_TF_DOCS -->