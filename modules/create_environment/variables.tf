/**
 * Copyright 2020 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

variable "project_id" {
  description = "Project ID where Cloud Composer Environment is created."
  type        = string
}

variable "composer_env_name" {
  description = "Name of Cloud Composer Environment"
  type        = string
}

variable "region" {
  description = "Region where the Cloud Composer Environment is created."
  type        = string
  default     = "us-central1"
}

variable "labels" {
  type        = map(string)
  description = "The resource labels (a map of key/value pairs) to be applied to the Cloud Composer."
  default     = {}
}

variable "network" {
  type        = string
  description = "The VPC network to host the composer cluster."
}

variable "network_project_id" {
  type        = string
  description = "The project ID of the shared VPC's host (for shared vpc support)"
  default     = ""
}

variable "subnetwork" {
  type        = string
  description = "The subnetwork to host the composer cluster."
}

variable "subnetwork_region" {
  type        = string
  description = "The subnetwork region of the shared VPC's host (for shared vpc support)"
  default     = ""
}

variable "zone" {
  description = "Zone where the Cloud Composer nodes are created."
  type        = string
  default     = "us-central1-f"
}

variable "node_count" {
  description = "Number of worker nodes in Cloud Composer Environment."
  type        = number
  default     = 3
}

variable "machine_type" {
  description = "Machine type of Cloud Composer nodes."
  type        = string
  default     = "n1-standard-8"
}

variable "composer_service_account" {
  description = "Service Account for running Cloud Composer."
  type        = string
  default     = null
}

variable "disk_size" {
  description = "The disk size for nodes."
  type        = string
  default     = "100"
}

variable "oauth_scopes" {
  description = "Google API scopes to be made available on all node."
  type        = set(string)
  default     = ["https://www.googleapis.com/auth/cloud-platform"]
}

variable "tags" {
  description = "Tags applied to all nodes. Tags are used to identify valid sources or targets for network firewalls."
  type        = set(string)
  default     = []
}

variable "use_ip_aliases" {
  description = "Enable Alias IPs in the GKE cluster. If true, a VPC-native cluster is created."
  type        = bool
  default     = false
}

variable "pod_ip_allocation_range_name" {
  description = "The name of the cluster's secondary range used to allocate IP addresses to pods."
  type        = string
  default     = null
}

variable "service_ip_allocation_range_name" {
  type        = string
  description = "The name of the services' secondary range used to allocate IP addresses to the cluster."
  default     = null
}

variable "airflow_config_overrides" {
  type        = map(string)
  description = "Airflow configuration properties to override. Property keys contain the section and property names, separated by a hyphen, for example \"core-dags_are_paused_at_creation\"."
  default     = {}
}

variable "env_variables" {
  type        = map(string)
  description = "Variables of the airflow environment."
  default     = {}
}

variable "image_version" {
  type        = string
  description = "The version of the aiflow running in the cloud composer environment."
  default     = null
}

variable "pypi_packages" {
  type        = map(string)
  description = " Custom Python Package Index (PyPI) packages to be installed in the environment. Keys refer to the lowercase package name (e.g. \"numpy\")."
  default     = {}
}

variable "python_version" {
  description = "The default version of Python used to run the Airflow scheduler, worker, and webserver processes."
  type        = string
  default     = "3"
}

variable "cloud_sql_ipv4_cidr" {
  description = "The CIDR block from which IP range in tenant project will be reserved for Cloud SQL."
  type        = string
  default     = null
}

variable "web_server_ipv4_cidr" {
  description = "The CIDR block from which IP range in tenant project will be reserved for the web server."
  type        = string
  default     = null
}

variable "master_ipv4_cidr" {
  description = "The CIDR block from which IP range in tenant project will be reserved for the master."
  type        = string
  default     = null
}

variable "enable_private_endpoint" {
  description = "Configure public access to the cluster endpoint."
  type        = bool
  default     = false
}

variable "kms_key_name" {
  description = "Customer-managed Encryption Key fully qualified resource name, i.e. projects/project-id/locations/location/keyRings/keyring/cryptoKeys/key."
  type        = string
  default     = null
}
