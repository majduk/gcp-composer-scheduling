/**
 * Copyright 2021 Google LLC
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
  description = "Project in which the vpc connector will be deployed."
}

variable "region" {
  type        = string
  description = "region in which the vpc connector will be deployed."
}

variable "vpc_access_cidr" {
  type        = string
  description = "Subnet CIDR in which the vpc connector will be deployed."
}

variable "network_project_id" {
  type        = string
  description = "Subnet host project in which the vpc connector will be deployed."
}

variable "shared_vpc_network" {
  type        = string
  description = "Shared VPC network in which the vpc connector subnet will be deployed."
}

