package main

#This will check that log sink exists to save the logs auditing and monitoring
#the exmaple below uses name "log_sink", change this name to match the existing name

sink_name := "logk_sink"
required_log_bucket_name="log-history"
bucket_required_asset_type="storage.googleapis.com/Bucket"
logsink_required_asset_type="logging.googleapis.com/LogSink"

# Validate bucket exists
deny[{"msg": message}] {
  bucket_required_asset_type == input.asset_type
  not required_log_bucket_name == input.resource.data.name
  message :=sprintf("The bucket '%s' does not exist", [input.resource.data.id])
}

# Validate log sink exists
 deny[{"msg": message}] {
  logsink_required_asset_type == input.asset_type
  not sink_name == input.resource.data.name
  message :=sprintf("The log sink '%s' does not exist", [input.resource.data.name])
}
