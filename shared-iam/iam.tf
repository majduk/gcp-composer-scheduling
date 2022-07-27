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
  trigger_sa_permissions      = ["roles/composer.user"]
}

data "google_project" "project" {
  project_id = var.project_id
}

# Composer Worker SA
resource "google_service_account" "dag_trigger_sa" {
  project      = var.project_id
  account_id   = "dag-trigger-sa"
  display_name = "Service account for triggering DAGs."
}

resource "google_project_iam_member" "iam_member_dag_trigger_roles" {
  for_each = { for role in local.trigger_sa_permissions : role => role }
  project  = var.project_id
  role     = each.key
  member   = "serviceAccount:${google_service_account.dag_trigger_sa.email}"
}

