
# Copyright 2022 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

locals {
  restricted_vip    = ["199.36.153.4/30"]
  load_balancer_ips = ["130.211.0.0/22", "35.191.0.0/16"]
}
/***
These firewall rules are crafted assuming that there is a "deny-egress" rule that most customers prefer to implement
/***
All firewall rules have been crafted based on the requirements specified in this link
https://cloud.google.com/composer/docs/composer-2/configure-private-ip#step_3_configure_firewall_rules

/****
1. Allow egress from GKE Node IP range to any destination (0.0.0.0/0), TCP/UDP port 53, or if you know DNS server IP addresses,
then allow egress from GKE Node IP range to DNS IP addresses over TCP/UDP port 53.
****/
resource "google_compute_firewall" "allow-composer-dns-egress" {
  name = "${var.composer_env_name}-allow-gke-dns-traffic"

  project = var.network_project_id
  network = var.network

  allow {
    protocol = "tcp"
    ports    = ["53"]
  }
  allow {
    protocol = "udp"
    ports    = ["53"]
  }

  direction               = "EGRESS"
  destination_ranges      = ["0.0.0.0/0"]
  target_service_accounts = [google_service_account.composer_sa.email]
  dynamic "log_config" {
    for_each = var.enable_firewall_logging ? [1] : []
    content {
      metadata = var.firewall_logging_metadata
    }
  }
}
/***
Allow egress traffic from GKE Node IP range to GKE Node IP range, all ports
Allow egress traffic between GKE Node IP range and Pods IP range, all ports.
Allow egress traffic between GKE Node IP range and Services IP range, all ports.
Allow egress traffic between GKE Pods and Services IP ranges, all ports.

**/
resource "google_compute_firewall" "allow-gke-egress-secondary-ranges" {
  name    = "${var.composer_env_name}-allow-gke-nodes-on-all-ports"
  project = var.network_project_id
  network = var.network

  allow {
    protocol = "all"
  }

  direction          = "EGRESS"
  destination_ranges = concat(var.gke_subnet_ip_range, var.gke_pods_services_ip_ranges)
  # destination_ranges = ["10.1.0.0/16","10.4.0.0/16", "10.10.10.0/24","10.10.14.0/24", "10.100.232.0/27"]
  target_service_accounts = [google_service_account.composer_sa.email]
  dynamic "log_config" {
    for_each = var.enable_firewall_logging ? [1] : []
    content {
      metadata = var.firewall_logging_metadata
    }
  }
}

/***
Allow ingress and egress from GKE Node IP range to GKE Control Plane IP range, all ports.
Note: Default Master IP Range is provided by google[4]
https://cloud.google.com/composer/docs/how-to/managing/configuring-private-ip#defaults
**/
resource "google_compute_firewall" "allow-gkeworkers-egress-master-ip" {
  name    = "${var.composer_env_name}-allow-gke-workers-to-gke-master-ip"
  project = var.network_project_id
  network = var.network

  allow {
    protocol = "all"
  }

  direction               = "EGRESS"
  destination_ranges      = var.master_ipv4_cidr != null ? [var.master_ipv4_cidr] : []
  target_service_accounts = [google_service_account.composer_sa.email]
  dynamic "log_config" {
    for_each = var.enable_firewall_logging ? [1] : []
    content {
      metadata = var.firewall_logging_metadata
    }
  }
}

/***
Allow egress from GKE Node IP range to 199.36.153.4/30, port 443 (restricted.googleapis.com)
***/
resource "google_compute_firewall" "allow-gkeworkers-restricted-vip" {
  name    = "${var.composer_env_name}-allow-gke-workers-to-restricted-vip"
  project = var.network_project_id
  network = var.network

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }
  target_service_accounts = [google_service_account.composer_sa.email]
  direction               = "EGRESS"
  destination_ranges      = local.restricted_vip

  dynamic "log_config" {
    for_each = var.enable_firewall_logging ? [1] : []
    content {
      metadata = var.firewall_logging_metadata
    }
  }
}
/***
Allow ingress from GCP Health Checks 130.211.0.0/22, 35.191.0.0/16 to GKE Node IP range, TCP ports 80 and 443.
***/
resource "google_compute_firewall" "allow-healthcheck-ingress-composer-gke" {
  name    = "${var.composer_env_name}-allow-health-check-ingress-composer-gke"
  project = var.network_project_id
  network = var.network

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]


  }
  target_service_accounts = [google_service_account.composer_sa.email]
  direction               = "INGRESS"
  source_ranges           = local.load_balancer_ips
  dynamic "log_config" {
    for_each = var.enable_firewall_logging ? [1] : []
    content {
      metadata = var.firewall_logging_metadata
    }
  }
}
/***
Allow egress from GKE Node IP range to GCP Health Checks 130.211.0.0/22, 35.191.0.0/16, TCP ports 80 and 443.
***/
resource "google_compute_firewall" "allow-healthcheck-egress-composer-gke" {
  name    = "${var.composer_env_name}-allow-health-check-egress-composer-gke"
  project = var.network_project_id
  network = var.network

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }
  target_service_accounts = [google_service_account.composer_sa.email]
  direction               = "EGRESS"
  destination_ranges      = local.load_balancer_ips

  dynamic "log_config" {
    for_each = var.enable_firewall_logging ? [1] : []
    content {
      metadata = var.firewall_logging_metadata
    }
  }
}

/***
Allow egress from GKE Node IP range to Cloud Composer network IP range, TCP ports 3306 and 3307.
**/
resource "google_compute_firewall" "allow-gkeworkers-composer-network-ip" {
  name    = "${var.composer_env_name}-allow-gke-workers-to-composer-network-ip"
  project = var.network_project_id
  network = var.network

  allow {
    protocol = "tcp"
    ports    = ["3306", "3307"]
  }
  target_service_accounts = [google_service_account.composer_sa.email]
  direction               = "EGRESS"
  destination_ranges      = var.cloud_composer_network_ipv4_cidr_block != null ? [var.cloud_composer_network_ipv4_cidr_block] : []

  dynamic "log_config" {
    for_each = var.enable_firewall_logging ? [1] : []
    content {
      metadata = var.firewall_logging_metadata
    }
  }
}
