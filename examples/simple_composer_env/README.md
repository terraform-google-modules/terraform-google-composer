# Simple Cloud Composer Environment Example

This example illustrates how to use the `composer` module.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| composer\_service\_account | Service Account to be used for creating Cloud Composer Environment. | string | n/a | yes |
| project\_id | Project ID where Cloud Composer Environment is created. | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| composer\_env\_name | The name of the Cloud Composer Environment. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

To provision this example, run the following from within this directory:
- `terraform init` to get the plugins
- `terraform plan` to see the infrastructure plan
- `terraform apply` to apply the infrastructure build
- `terraform destroy` to destroy the built infrastructure
