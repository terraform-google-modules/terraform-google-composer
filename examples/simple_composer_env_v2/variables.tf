/**
 * Copyright 2022 Google LLC
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
  description = "Name of Cloud Composer Environment."
  default     = "ci-composer"
  type        = string
}

variable "region" {
  description = "Region where Cloud Composer Environment is created."
  type        = string
}

variable "composer_service_account" {
  description = "Service Account to be used for running Cloud Composer Environment."
  type        = string
}

variable "network" {
  description = "Network where Cloud Composer is created."
  type        = string
}

variable "subnetwork" {
  description = "Name of the Subetwork where Cloud Composer is created."
  type        = string
}

variable "subnetwork_self_link" {
  description = "self_link of the Subetwork where Cloud Composer is created."
  type        = string
}

variable "pod_ip_allocation_range_name" {
  description = "The name of the cluster's secondary range used to allocate IP addresses to pods."
  type        = string
}

variable "service_ip_allocation_range_name" {
  type        = string
  description = "The name of the services' secondary range used to allocate IP addresses to the cluster."
}
