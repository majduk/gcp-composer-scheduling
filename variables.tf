# Copyright 2022 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

variable "terraform_service_account" {
  description = "Service account email of the account to impersonate to run Terraform."
  type        = string
}

variable "project_id" {
  description = "Project ID where the resources are created"
  type        = string
}

variable "region" {
  description = "Region where the resources are created"
  type        = string
}

variable "vpc_access_cidr" {
  description = "Network CIDR range (/28) that the created serverless access will have."
  type        = string
}

variable "network_project_id" {
  description = "Shared VPC host project where the resources are created"
  type        = string
}

variable "shared_vpc_network" {
  type        = string
  description = "Shared VPC network in which the vpc connector subnet will be deployed."
}

