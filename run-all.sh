#This script will run through all the checks

#First step is to enable Cloud Asset Inventory API
gcloud services enable cloudasset.googleapis.com

#Create a storage bucket for storing the asset inventory output. Replace bucket name with your bucket
#export MY_BUCKET_NAME=<bucket-name>

export MY_BUCKET_NAME=guardrails-bucket
gsutil mb gs://$MY_BUCKET_NAME

#Run inventory report. This will export resource assets for the checks

gcloud asset export --output-path=gs://$MY_BUCKET_NAME/resource_inventory.json --content-type=resource --project=soy-geography-279112 

#List the log sinks for check 11
#gcloud beta logging sinks list --format=json | sed 's/\[//;s/\]//' | gsutil cp - gs://$MY_BUCKET_NAME/logsinks.json

#Copy the inventory content to the working directory 

gsutil cp gs://$MY_BUCKET_NAME/*.json ./cai-dir

# Run the Tests
./run-checks.sh