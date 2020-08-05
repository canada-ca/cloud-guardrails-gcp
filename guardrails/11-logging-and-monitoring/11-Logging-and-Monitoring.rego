package main

# This will check that log sink exists to save the logs auditing and monitoring
# the example below uses name "log_sink", change this name to match the existing name

sink_name := "log_sink"
required_log_bucket_name="log-history"
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
    
    message := sprintf("Guardrail # 11: No storage bucket matching '%v' found. Asset Name '%v'", [required_log_bucket_name, asset[_].name])

}

# Deny if "logging.googleapis.com/LogSink" asset does not exist
deny[{"msg":message}] {

        asset := input.data
        not exists(asset) 

        message := sprintf("Guardrail # 11: Asset Type '%s' does not exist and is required to meet logging criteria", ["logging.googleapis.com/LogSink"])
}

# Deny if Log Sync does not exist that matches $sink_name (set this value at the top of the file)
deny [{"msg":message}] {
    asset := input.data[_]
    
    asset.asset_type == loggingAsset
    
    not sink_name == asset.resource.data.name
    
    message := sprintf("Guardrail # 11: The log sink '%s' does not exist", [sink_name])
}

bucketCheck(assetdata) {
    assetdata[_].resource.data.name == required_log_bucket_name
}

exists(asset_type){
        asset_type[_].asset_type == "logging.googleapis.com/LogSink"
}

