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
resource "google_dns_managed_zone" "google-apis" {
  name        = "restricted-googleapis-zone"
  project     = module.project.project_id
  dns_name    = "googleapis.com."
  description = "restricted zone for Google APIs"

  visibility = "private"

  private_visibility_config {
    networks {
      network_url = module.shared-vpc.network_self_link
    }
  }
}

resource "google_dns_record_set" "restricted-google-apis-A-record" {
  name    = "restricted.googleapis.com."
  project = module.project.project_id
  type    = "A"
  ttl     = 300

  managed_zone = google_dns_managed_zone.google-apis.name

  rrdatas = ["199.36.153.4", "199.36.153.5", "199.36.153.6", "199.36.153.7"]
}

resource "google_dns_record_set" "google-api-CNAME" {
  name    = "*.googleapis.com."
  project = module.project.project_id
  type    = "CNAME"
  ttl     = 300

  managed_zone = google_dns_managed_zone.google-apis.name

  rrdatas = ["restricted.googleapis.com."]
}

resource "google_dns_managed_zone" "gcr-io" {
  name        = "gcr-io-zone"
  project     = module.project.project_id
  dns_name    = "gcr.io."
  description = "private zone for GCR.io"

  visibility = "private"

  private_visibility_config {
    networks {
      network_url = module.shared-vpc.network_self_link
    }
  }
}

resource "google_dns_record_set" "restricted-gcr-io-A-record" {
  name    = "gcr.io."
  project = module.project.project_id
  type    = "A"
  ttl     = 300

  managed_zone = google_dns_managed_zone.gcr-io.name

  rrdatas = ["199.36.153.4", "199.36.153.5", "199.36.153.6", "199.36.153.7"]
}

resource "google_dns_record_set" "gcr-io-CNAME" {
  name    = "*.gcr.io."
  project = module.project.project_id
  type    = "CNAME"
  ttl     = 300

  managed_zone = google_dns_managed_zone.gcr-io.name

  rrdatas = ["gcr.io."]
}

resource "google_dns_managed_zone" "pkg-dev" {
  name        = "pkg-dev-zone"
  project     = module.project.project_id
  dns_name    = "pkg.dev."
  description = "pkg dev private zone"

  visibility = "private"

  private_visibility_config {
    networks {
      network_url = module.shared-vpc.network_self_link
    }
  }
}

resource "google_dns_record_set" "restricted-pkg-dev-A-record" {
  name    = "pkg.dev."
  project = module.project.project_id
  type    = "A"
  ttl     = 300

  managed_zone = google_dns_managed_zone.pkg-dev.name

  rrdatas = ["199.36.153.4", "199.36.153.5", "199.36.153.6", "199.36.153.7"]
}

resource "google_dns_record_set" "pkg-dev-CNAME" {
  name    = "*.pkg.dev."
  project = module.project.project_id
  type    = "CNAME"
  ttl     = 300

  managed_zone = google_dns_managed_zone.pkg-dev.name

  rrdatas = ["pkg.dev."]
}
