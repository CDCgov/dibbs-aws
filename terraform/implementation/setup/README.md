<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.9.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.86.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | ~> 2.5.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.6.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_local"></a> [local](#provider\_local) | 2.5.3 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.6.3 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_oidc_dev"></a> [oidc\_dev](#module\_oidc\_dev) | ../../modules/oidc | n/a |
| <a name="module_oidc_prod"></a> [oidc\_prod](#module\_oidc\_prod) | ../../modules/oidc | n/a |
| <a name="module_tfstate"></a> [tfstate](#module\_tfstate) | ../../modules/tfstate | n/a |

## Resources

| Name | Type |
|------|------|
| [local_file.setup_env](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [random_string.setup](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_oidc_github_repo"></a> [oidc\_github\_repo](#input\_oidc\_github\_repo) | The GitHub repository for OIDC | `string` | `""` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | The owner of the project | `string` | `"skylight"` | no |
| <a name="input_project"></a> [project](#input\_project) | The name of the project | `string` | `"dibbs"` | no |
| <a name="input_region"></a> [region](#input\_region) | The AWS region where resources are created | `string` | `"us-east-1"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->