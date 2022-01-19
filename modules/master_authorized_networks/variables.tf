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
  type        = string
  description = "Project ID where Cloud Composer Environment is created."
}

variable "zone" {
  type        = string
  description = "Zone where the Cloud Composer Kubernetes Master lives."
}

variable "gke_cluster" {
  type        = string
  description = "Name of the Cloud Composer Kubernetes cluster."
}

variable "master_authorized_networks" {
  type        = list(object({ cidr_block = string, display_name = string }))
  description = "List of master authorized networks. If null is provided this module will do nothing. If empty string then all public traffic will be denied"
  default     = null
}



