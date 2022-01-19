# Module Cloud Composer Authorized Network

This optional module is used to configure the underlying Kubernetes Authorized Networks

Unfortunately this capability is not exposed via the Composer API so we need to use `gcloud`

If we initially have `enabled=false` then it will use the default set by Composer

```hcl
module "authorized_networks" {
  source      = "terraform-google-modules/composer/google//modules/authorized_networks"
  project     = "project-123"
  environment = "Composer-Prod-Env"
  location    = "us-central1"

  master_authorized_networks = [
    {
      cidr_block = "0.0.0.0/0"
      display_name = "The world (Not a good idea)"
    },
  ]
}
```

See the examples for cloudsql support.

```
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| gke\_cluster | Name of the Cloud Composer Kubernetes cluster. | `string` | n/a | yes |
| master\_authorized\_networks | List of master authorized networks. If null is provided this module will do nothing. If empty string then all public traffic will be denied | `list(object({ cidr_block = string, display_name = string }))` | `null` | no |
| project\_id | Project ID where Cloud Composer Environment is created. | `string` | n/a | yes |
| zone | Zone where the Cloud Composer Kubernetes Master lives. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| wait | An output to use when you want to depend on cmd finishing |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
