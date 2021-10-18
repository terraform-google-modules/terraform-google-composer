# Module Cloud Composer Connection

This optional module is used to create a Cloud Composer Connection.

```hcl
module "connection" {
  source      = "terraform-google-modules/composer/google//modules/airflow_connection"
  project     = "project-123"
  environment = "Composer-Prod-Env"
  location    = "us-central1"
  id          = "my-database"
  host        = var.host
  login       = var.user
  password    = var.password
}
```

See the examples for cloudsql support.

```
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| composer\_env\_name | Name of the Cloud Composer Environment. | `string` | n/a | yes |
| enabled | Whether to create this resource or not | `bool` | `true` | no |
| extra | The optional exta field of the connection. If this is not a string it will be encoded as json which is useful for things like oauth tokens and gcpcloudsql | `any` | `null` | no |
| host | The optional host field of the connection | `string` | `null` | no |
| id | The ID of the connection within Airflow | `string` | n/a | yes |
| login | The optional login field of the connection | `string` | `null` | no |
| password | The optional password field of the connection | `string` | `null` | no |
| port | The optional port field of the connection | `string` | `null` | no |
| project\_id | Project ID where Cloud Composer Environment is created. | `string` | n/a | yes |
| region | Region where the Cloud Composer Environment is created. | `string` | n/a | yes |
| schema | The optional schema field of the connection | `string` | `null` | no |
| type | The optional type field of the connection | `string` | `null` | no |
| uri | The optional uri field of the connection | `string` | `null` | no |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
