<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |

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
| [null_resource.target_groups](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [aws_iam_policy.amazon_ec2_container_service_for_ec2_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy.ecs_task_execution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy_document.assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ecr_viewer_s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_appmesh_name"></a> [appmesh\_name](#input\_appmesh\_name) | Name of the AWS App Mesh | `string` | n/a | yes |
| <a name="input_cloudmap_namespace_name"></a> [cloudmap\_namespace\_name](#input\_cloudmap\_namespace\_name) | Name of the AWS Cloud Map namespace | `string` | n/a | yes |
| <a name="input_cloudmap_service_name"></a> [cloudmap\_service\_name](#input\_cloudmap\_service\_name) | Name of the AWS Cloud Map service | `string` | n/a | yes |
| <a name="input_cw_retention_in_days"></a> [cw\_retention\_in\_days](#input\_cw\_retention\_in\_days) | Retention period in days for CloudWatch logs | `number` | n/a | yes |
| <a name="input_ecs_alb_name"></a> [ecs\_alb\_name](#input\_ecs\_alb\_name) | Name of the Application Load Balancer (ALB) | `string` | n/a | yes |
| <a name="input_ecs_alb_tg_name"></a> [ecs\_alb\_tg\_name](#input\_ecs\_alb\_tg\_name) | Name of the ALB Target Group | `string` | n/a | yes |
| <a name="input_ecs_cloudwatch_group"></a> [ecs\_cloudwatch\_group](#input\_ecs\_cloudwatch\_group) | Name of the AWS CloudWatch Log Group for ECS | `any` | n/a | yes |
| <a name="input_ecs_cluster_name"></a> [ecs\_cluster\_name](#input\_ecs\_cluster\_name) | Name of the ECS Cluster | `string` | n/a | yes |
| <a name="input_ecs_task_execution_role_name"></a> [ecs\_task\_execution\_role\_name](#input\_ecs\_task\_execution\_role\_name) | Name of the ECS Task Execution Role | `string` | n/a | yes |
| <a name="input_ecs_task_role_name"></a> [ecs\_task\_role\_name](#input\_ecs\_task\_role\_name) | Name of the ECS Task Role | `string` | n/a | yes |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | List of private subnet IDs | `list(string)` | n/a | yes |
| <a name="input_public_subnet_ids"></a> [public\_subnet\_ids](#input\_public\_subnet\_ids) | List of public subnet IDs | `list(string)` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The AWS region where resources are created | `string` | n/a | yes |
| <a name="input_s3_viewer_bucket_name"></a> [s3\_viewer\_bucket\_name](#input\_s3\_viewer\_bucket\_name) | Name of the S3 bucket for the viewer | `string` | n/a | yes |
| <a name="input_s3_viewer_bucket_role_name"></a> [s3\_viewer\_bucket\_role\_name](#input\_s3\_viewer\_bucket\_role\_name) | Name of the IAM role for the ecr-viewer bucket | `string` | n/a | yes |
| <a name="input_service_data"></a> [service\_data](#input\_service\_data) | Data for the DIBBS services | <pre>map(object({<br>    short_name     = string<br>    fargate_cpu    = number<br>    fargate_memory = number<br>    app_count      = number<br>    app_image      = string<br>    app_version    = string<br>    container_port = number<br>    host_port      = number<br>    public         = bool<br>    env_vars       = list(object({<br>      name  = string<br>      value = string<br>    }))<br>  }))</pre> | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the VPC | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->