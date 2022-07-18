# Module Cloud Composer Environment ([V1](https://cloud.google.com/composer/docs/concepts/overview))

This optional module is used to create a Cloud Composer environment.

```hcl
module "composer" {
  source = "terraform-google-modules/composer/google//modules/create_environment_v1"

  project = "project-123"
  name    = "Composer-Prod-Env"
  region  = "us-central1"

  config {
    node_count = "3"

    node_config {
      zone         = "us-central1-f"
      machine_type = "n1-standard-1"
      network    = "test-network"
      subnetwork = "test-subnetwork"
    }
  }
}
```
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| airflow\_config\_overrides | Airflow configuration properties to override. Property keys contain the section and property names, separated by a hyphen, for example "core-dags\_are\_paused\_at\_creation". | `map(string)` | `{}` | no |
| cloud\_sql\_ipv4\_cidr | The CIDR block from which IP range in tenant project will be reserved for Cloud SQL. | `string` | `null` | no |
| composer\_env\_name | Name of Cloud Composer Environment | `string` | n/a | yes |
| composer\_service\_account | Service Account for running Cloud Composer. | `string` | `null` | no |
| disk\_size | The disk size for nodes. | `string` | `"100"` | no |
| enable\_ip\_masq\_agent | Deploys 'ip-masq-agent' daemon set in the GKE cluster and defines nonMasqueradeCIDRs equals to pod IP range so IP masquerading is used for all destination addresses, except between pods traffic. | `bool` | `false` | no |
| enable\_private\_endpoint | Configure public access to the cluster endpoint. | `bool` | `false` | no |
| env\_variables | Variables of the airflow environment. | `map(string)` | `{}` | no |
| image\_version | The version of the aiflow running in the cloud composer environment. | `string` | `null` | no |
| kms\_key\_name | Customer-managed Encryption Key fully qualified resource name, i.e. projects/project-id/locations/location/keyRings/keyring/cryptoKeys/key. | `string` | `null` | no |
| labels | The resource labels (a map of key/value pairs) to be applied to the Cloud Composer. | `map(string)` | `{}` | no |
| machine\_type | Machine type of Cloud Composer nodes. | `string` | `"n1-standard-8"` | no |
| master\_ipv4\_cidr | The CIDR block from which IP range in tenant project will be reserved for the master. | `string` | `null` | no |
| network | The VPC network to host the composer cluster. | `string` | n/a | yes |
| network\_project\_id | The project ID of the shared VPC's host (for shared vpc support) | `string` | `""` | no |
| node\_count | Number of worker nodes in Cloud Composer Environment. | `number` | `3` | no |
| oauth\_scopes | Google API scopes to be made available on all node. | `set(string)` | <pre>[<br>  "https://www.googleapis.com/auth/cloud-platform"<br>]</pre> | no |
| pod\_ip\_allocation\_range\_name | The name of the cluster's secondary range used to allocate IP addresses to pods. | `string` | `null` | no |
| project\_id | Project ID where Cloud Composer Environment is created. | `string` | n/a | yes |
| pypi\_packages | Custom Python Package Index (PyPI) packages to be installed in the environment. Keys refer to the lowercase package name (e.g. "numpy"). | `map(string)` | `{}` | no |
| python\_version | The default version of Python used to run the Airflow scheduler, worker, and webserver processes. | `string` | `"3"` | no |
| region | Region where the Cloud Composer Environment is created. | `string` | `"us-central1"` | no |
| service\_ip\_allocation\_range\_name | The name of the services' secondary range used to allocate IP addresses to the cluster. | `string` | `null` | no |
| subnetwork | The subnetwork to host the composer cluster. | `string` | n/a | yes |
| subnetwork\_region | The subnetwork region of the shared VPC's host (for shared vpc support) | `string` | `""` | no |
| tags | Tags applied to all nodes. Tags are used to identify valid sources or targets for network firewalls. | `set(string)` | `[]` | no |
| use\_ip\_aliases | Enable Alias IPs in the GKE cluster. If true, a VPC-native cluster is created. | `bool` | `false` | no |
| web\_server\_allowed\_ip\_ranges | The network-level access control policy for the Airflow web server. If unspecified, no network-level access restrictions will be applied. | <pre>list(object({<br>    value       = string,<br>    description = string<br>  }))</pre> | `null` | no |
| web\_server\_ipv4\_cidr | The CIDR block from which IP range in tenant project will be reserved for the web server. | `string` | `null` | no |
| zone | Zone where the Cloud Composer nodes are created. | `string` | `"us-central1-f"` | no |

## Outputs

| Name | Description |
|------|-------------|
| airflow\_uri | URI of the Apache Airflow Web UI hosted within the Cloud Composer Environment. |
| composer\_env\_id | ID of Cloud Composer Environment. |
| composer\_env\_name | Name of the Cloud Composer Environment. |
| gcs\_bucket | Google Cloud Storage bucket which hosts DAGs for the Cloud Composer Environment. |
| gke\_cluster | Google Kubernetes Engine cluster used to run the Cloud Composer Environment. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
