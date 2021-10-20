# Module Cloud Composer Pool

This optional module is used to create a Cloud Composer Pool.

```hcl
module "pool" {
  source      = "terraform-google-modules/composer/google//modules/airflow_pool"

  project_id  = "project-123"
  environment = "Composer-Prod-Env"
  location    = "us-central1"
  name        = "beta"
  slots       = 1000
  description = "Pool used by beta DAGs"
}
```

```
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| composer\_env\_name | Name of the Cloud Composer Environment. | `string` | n/a | yes |
| description | The description of the pool | `string` | `""` | no |
| enabled | Whether to create this resource or not | `bool` | `true` | no |
| pool\_name | The name of the pool | `string` | n/a | yes |
| project\_id | Project ID where Cloud Composer Environment is created. | `string` | n/a | yes |
| region | Region where the Cloud Composer Environment is created. | `string` | n/a | yes |
| slot\_count | The number of slots in this pool | `number` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| wait | An output to use when you want to depend on cmd finishing |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
