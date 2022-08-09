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
import future.keywords.in

# This will check that log sink exists to save the logs auditing and monitoring
# the example below uses name "log_sink", change this name to match the existing name

sink_name := "org_log_sink"
required_log_bucket_name="logginglogsink-goc"
bucket_required_asset_type="storage.googleapis.com/Bucket"
logsink_required_asset_type="logging.googleapis.com/LogSink"
required_asset_type = "storage.googleapis.com/Bucket"
loggingAsset = "logging.googleapis.com/LogSink"

# Check for matching Bucket with the name "log-history"
deny [{"msg": message}] {

    asset := input.data
    
    asset[_].asset_type == required_asset_type
    not bucketCheck(asset)
    # not asset.resource.data.name == required_log_bucket_name
    
    message := sprintf("Guardrail # 11: No storage bucket matching '%v' found.", [required_log_bucket_name])

}

# Deny if "logging.googleapis.com/LogSink" asset does not exist
deny[{"msg":message}] {

        asset := input.data
        not exists(asset) 

        message := sprintf("Guardrail # 11: Asset Type '%s' does not exist and is required to meet logging criteria", ["logging.googleapis.com/LogSink"])
}

# Deny if Log Sync does not exist that matches $sink_name (set this value at the top of the file)
deny [{"msg":message}] {
    
    not sink_name in resource_names

    # not test
    message := sprintf("Guardrail # 11: The log sink '%s' does not exist.", [sink_name])

}

resource_names[name] {
    some item in input.data
    name := item.resource.data.name
}

bucketCheck(assetdata) {
    assetdata[_].resource.data.name == required_log_bucket_name
}

exists(asset_type){
        asset_type[_].asset_type == "logging.googleapis.com/LogSink"
}

