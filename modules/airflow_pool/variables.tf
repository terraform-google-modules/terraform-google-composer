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

variable "enabled" {
  type        = bool
  default     = true
  description = "Whether to create this resource or not"
}

variable "region" {
  type        = string
  description = "Region where the Cloud Composer Environment is created."
}

variable "composer_env_name" {
  type        = string
  description = "Name of the Cloud Composer Environment."
}

variable "pool_name" {
  type        = string
  description = "The name of the pool"
}

variable "slot_count" {
  type        = number
  description = "The number of slots in this pool"
}

variable "description" {
  type        = string
  description = "The description of the pool"
  default     = ""
}
