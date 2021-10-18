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
  type = string
}

variable "enabled" {
  type    = bool
  default = true
}

variable "location" {
  type = string
}

variable "environment" {
  type = string
}

variable "id" {
  type = string
}

variable "host" {
  type    = string
  default = null
}


variable "uri" {
  type      = string
  default   = null
  sensitive = true
}

variable "login" {
  type      = string
  default   = null
  sensitive = true
}

variable "password" {
  type      = string
  default   = null
  sensitive = true
}

variable "port" {
  type    = string
  default = null
}

variable "schema" {
  type    = string
  default = null
}

variable "type" {
  type    = string
  default = null
}

variable "extra" {
  type        = any
  description = "If this is not a string it will be encoded as json for things like oauth tokens"
  default     = null
  sensitive   = true
}



