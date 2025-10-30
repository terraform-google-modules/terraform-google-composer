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
  cidr_list_arg = (
    length(coalesce(var.master_authorized_networks, [])) > 0 ?
    "--master-authorized-networks ${join(",", [for b in var.master_authorized_networks : b.cidr_block])}" : ""
  )

  gcloud_cmd_body = "container clusters update --project=${var.project_id} --zone=${var.zone} ${var.gke_cluster}"
  create_cmd_body = "${local.gcloud_cmd_body} --enable-master-authorized-networks ${local.cidr_list_arg}"
  # At the time of writing the Composer default is to close it to the outside world
  destroy_cmd_body = "${local.gcloud_cmd_body} --enable-master-authorized-networks"
}

module "gcloud" {
  source           = "terraform-google-modules/gcloud/google"
  enabled          = var.master_authorized_networks != null
  version          = "~> 4.0"
  platform         = "linux"
  create_cmd_body  = local.create_cmd_body
  destroy_cmd_body = local.destroy_cmd_body
}
