################
# Copyright 2021 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#################

package main

# Dissallow Private Catalog Admin to prevent it being used by unauthorized users
# With this permission users can create private catalogs for the GCP workspace
bad_roles = ["roles/cloudprivatecatalogproducer.admin"]

deny[{"msg": message}] {

	asset := input.data[_]
    rolebinding := asset.iam_policy.bindings
    roles := bad_roles
    invalid_role(rolebinding, roles)

    message := sprintf("Guardrail # 12: Resource '%v' has Policy Role Binding '%v'", [asset.name, bad_roles])
    
}

# Users that are allowed to use the above Roles
allowedusers = []

# Does the role binding mastch the disallowed role
invalid_role (rolebinding, roles){
        rolebinding[_].role == roles[_]
}

# Checks Members list for matching pattern
containsuser (users, pattern) {
    contains(users,pattern[_])
}
