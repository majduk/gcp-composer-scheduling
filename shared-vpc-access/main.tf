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

data "google_compute_network" "shared_vpc_network" {
  project = var.network_project_id
  name    = var.shared_vpc_network 
}

resource "google_project_service" "vpcaccess-api" {
  project = var.project_id
  service = "vpcaccess.googleapis.com"
}

resource "google_compute_subnetwork" "vpc_access_subnetwork" {
  name            = "vpcaccess-${var.region}"
  ip_cidr_range   = var.vpc_access_cidr
  region          = var.region
  project = var.network_project_id
  network         = data.google_compute_network.shared_vpc_network.id
}

module "serverless-connector" {
  source     = "terraform-google-modules/network/google//modules/vpc-serverless-connector-beta"
  project_id = var.project_id
  vpc_connectors = [{
    name        = "vpcconn-${var.region}"
    region      = var.region
    subnet_name = google_compute_subnetwork.vpc_access_subnetwork.name
    host_project_id = var.network_project_id
    machine_type  = "e2-standard-4"
    min_instances = 2
    max_instances = 7
    }
  ]
  depends_on = [
    google_project_service.vpcaccess-api,
    google_compute_subnetwork.vpc_access_subnetwork
  ]
}
