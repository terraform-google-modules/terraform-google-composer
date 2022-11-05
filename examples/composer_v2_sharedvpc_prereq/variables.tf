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

variable "service_project_id" {
  description = "Project ID where Cloud Composer Environment is created."
  type        = string
}

variable "project_id" {
  type        = string
  description = "The project ID of the shared VPC's host (for shared vpc support)"
}

variable "composer_sa" {
  description = "Service Account to be used for running Cloud Composer Environment."
  type        = string
}

variable "region" {
  description = "Region where Cloud Composer Environment is created."
  type        = string
  default     = "us-central1"
}

variable "network" {
  type        = string
  description = "The name of the network being created"
}

