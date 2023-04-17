################
# Copyright 2023 Google LLC
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

import future.keywords.in

# This will check that log sink exists to save the logs auditing and monitoring
# the example below uses name "log_sink", change this name to match the existing name

required_log_bucket_name_suffix = "-org-sink"

required_storage_bucket_name_suffix = "bucket"

bucket_required_asset_type = "storage.googleapis.com/Bucket"

logsink_required_asset_type = "logging.googleapis.com/LogSink"

logsink_destination_storagebucket_prefix = "storage.googleapis.com"

logsink_destination_logbucket_prefix = "logging.googleapis.com"


# Deny if not any organization log sink exists
deny[{"msg": message}] {
	count(organization_sinks) == 0

	# not test
	message := "Guardrail # 11: No any organizational log sink exists."
}

# Deny if organization log sink does not any destination defined
deny[{"msg": message}] {
    some sink in organization_sinks
    not sink.resource.data.destination

	# not test
	message := "Guardrail # 11: No any destination for organization log sink exists."
}

# Deny if log bucket destination does not exist
deny[{"msg": message}] {
    some sink in organization_sinks
    not startswith(sink.resource.data.destination, logsink_destination_logbucket_prefix)

	# not test
	message := "Guardrail # 11: No any log bucket destination for organization log sink exists."
}

organization_sinks[sink] {
	some item in input.data
	item.asset_type == logsink_required_asset_type
    item.resource.data.includeChildren == true
    endswith(item.resource.data.name, required_log_bucket_name_suffix)
	some ancestor in item.ancestors
	startswith(ancestor, "organizations/")
	sink := item
}
