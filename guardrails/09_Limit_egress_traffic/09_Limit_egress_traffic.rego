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

has_egress(obj, field){
   obj[field]
}

denylist = [
   "0.0.0.0/0"
]

firewall_match(str, pattern) {
   contains(str,pattern[_])
}

deny[{"msg": message}] {

   asset := input.data[_]

   has_egress(asset.resource.data, "destinationRanges")

   firewall_match(asset.resource.data.destinationRanges[0], denylist)

   message := sprintf("Guardrail # 9: Resource '%v' egress allowed range '%v'", [asset.name, asset.resource.data.destinationRanges[0]])
	
}
