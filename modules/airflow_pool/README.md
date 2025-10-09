# Module Cloud Composer Pool

This optional module is used to create a Cloud Composer Pool.

```hcl
module "pool" {
  source      = "terraform-google-modules/composer/google//modules/airflow_pool"

  project           = "project-123"
  environment       = "Composer-Prod-Env"
  location          = "us-central1"
  composer_env_name = "beta"
  slot_count        = 1000
  description       = "Pool used by beta DAGs"
}
```

> [!IMPORTANT]
> to delete a pool you first need to run
> ``` terraform destroy --target module.however_you_named_it ```
> if you just remove the module configuration from your code the pool will not be deleted.

```
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| composer\_env\_name | Name of the Cloud Composer Environment. | `string` | n/a | yes |
| description | The description of the pool | `string` | `"Managed by Terraform"` | no |
| pool\_name | The name of the pool | `string` | n/a | yes |
| project | Project name where Cloud Composer Environment is created. | `string` | n/a | yes |
| region | Region where the Cloud Composer Environment is created. | `string` | n/a | yes |
| slot\_count | The number of slots in this pool | `number` | n/a | yes |
| include_deferred | Whether the pool should include deferred tasks in its calculation of occupied slots | `bool` | false | no |

## Outputs

| Name | Description |
|------|-------------|
| wait | An output to use when you want to depend on cmd finishing |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
