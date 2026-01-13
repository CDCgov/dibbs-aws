<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.9.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.86.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.6.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.86.0 |
| <a name="provider_random"></a> [random](#provider\_random) | ~> 3.6.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket.replication](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_versioning.replication](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [random_string.replication](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_s3_replication_bucket_name"></a> [s3\_replication\_bucket\_name](#input\_s3\_replication\_bucket\_name) | Name of the S3 bucket for replication | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_s3_replication_bucket_arn"></a> [s3\_replication\_bucket\_arn](#output\_s3\_replication\_bucket\_arn) | n/a |
| <a name="output_s3_replication_bucket_name"></a> [s3\_replication\_bucket\_name](#output\_s3\_replication\_bucket\_name) | n/a |
<!-- END_TF_DOCS -->