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

locals {
  # Emulate the default behaviour when --destination isn't set otherwise we don't know how to run the destroy command
  implied_destination = coalesce(var.destination_path, basename(var.source_path))
  create_parameters = {
    "--project"     = var.project_id
    "--location"    = var.location
    "--environment" = var.environment
    "--source"      = var.source_path
    "--destination" = var.destination_path
  }
  destroy_parameters = {
    "--project"     = var.project_id
    "--location"    = var.location
    "--environment" = var.environment
  }

  gcloud_cmd_body  = "composer environments storage ${var.type}"
  create_cmd_body  = "${local.gcloud_cmd_body} import ${join(" ", [for k, v in local.create_parameters : "${k}=${v}" if v != null])}"
  destroy_cmd_body = "${local.gcloud_cmd_body} delete ${join(" ", [for k, v in local.destroy_parameters : "${k}=${v}"])} ${local.implied_destination}"
}


module "gcloud" {
  source           = "terraform-google-modules/gcloud/google"
  version          = "~> 4.0"
  platform         = "linux"
  create_cmd_body  = local.create_cmd_body
  destroy_cmd_body = local.destroy_cmd_body

  create_cmd_triggers = {
    filesha1 = join(",", [
      for f in fileset(var.source_path, "**") : "${f}:${filesha1("${var.source_path}/${f}")}"
    ])
  }
}
