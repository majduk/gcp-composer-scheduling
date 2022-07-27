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

locals {
  connector_sa_permissions      = ["roles/compute.networkUser"]
  cloud_services_sa = "${data.google_project.project.number}@cloudservices.gserviceaccount.com"
  connector_sa = "service-${data.google_project.project.number}@gcp-sa-vpcaccess.iam.gserviceaccount.com"
}

data "google_project" "project" {
  project_id = var.project_id
}

resource "google_project_iam_member" "iam_connector_sa_roles" {
  for_each = { for role in local.connector_sa_permissions : role => role }
  project  = var.network_project_id
  role     = each.key
  member   = "serviceAccount:${local.connector_sa}"
}

resource "google_project_iam_member" "iam_services_sa_roles" {
  for_each = { for role in local.connector_sa_permissions : role => role }
  project  = var.project_id
  role     = each.key
  member   = "serviceAccount:${local.cloud_services_sa}"
}

resource "google_project_iam_member" "iam_host_services_sa_roles" {
  for_each = { for role in local.connector_sa_permissions : role => role }
  project  = var.network_project_id
  role     = each.key
  member   = "serviceAccount:${local.cloud_services_sa}"
}

