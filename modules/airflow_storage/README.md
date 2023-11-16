# Module Cloud Composer Storage

This optional module is used to configure Airflow objects like dags, plugins and data.

Unfortunately this capability is not exposed via the Composer API so we need to use `gcloud`

```hcl
module "my-dag" {
  source      = "terraform-google-modules/composer/google//modules/airflow_storage"
  project_id  = "project-123"
  environment = "Composer-Prod-Env"
  location    = "us-central1"
  type        = "dag"
  source_path = "${path.root}/dags/my-dag"
}
```

See the examples for cloudsql support.

```
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| destination\_path | The optional destination path | `string` | `null` | no |
| environment | Environment | `string` | n/a | yes |
| location | Location of the resource | `string` | n/a | yes |
| project\_id | Project ID | `string` | n/a | yes |
| source\_path | The source on the local file system | `string` | n/a | yes |
| type | The type of resource to upload. Either dag, plugin or data | `string` | n/a | yes |

## Outputs

No outputs.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
