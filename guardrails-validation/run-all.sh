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

#This script will run through all the checks

#First step is to enable Cloud Asset Inventory API
gcloud services enable cloudasset.googleapis.com

#Create a storage bucket for storing the asset inventory output. Replace bucket name with your bucket
#export MY_BUCKET_NAME=<bucket-name>

export MY_BUCKET_NAME=guardrails-bucket-anthos-gcp
export PROJECT=$(gcloud config get-value project)
gsutil mb gs://$MY_BUCKET_NAME

#Run inventory report. This will export resource assets for the checks

gcloud asset export --output-path=gs://$MY_BUCKET_NAME/resource_inventory.json --content-type=resource --project=$PROJECT 

#List the log sinks for check 11
#gcloud beta logging sinks list --format=json | sed 's/\[//;s/\]//' | gsutil cp - gs://$MY_BUCKET_NAME/logsinks.json

#Copy the inventory content to the working directory 

gsutil cp gs://$MY_BUCKET_NAME/resource_inventory.json ./cai-dir

# Run the Tests
./run-checks.sh