# GC Cloud Guardrails

## Source Links
[Cloud Foundation Scorcard](https://github.com/GoogleCloudPlatform/cloud-foundation-toolkit/blob/master/cli/docs/scorecard.mdhttps://github.com/GoogleCloudPlatform/cloud-foundation-toolkit/blob/master/cli/docs/scorecard.md)

[Cloud Inventory Assets](https://cloud.google.com/asset-inventory/docs/overviewhttps://cloud.google.com/asset-inventory/docs/overview)

##  Process

### Generate Inventory
1. Enable Cloud Asset Inventory API
```
gcloud services enable cloudasset.googleapis.com
```

2. Create a storage bucket for storing the asset inventory output
```
gsutil mb gs://<your_bucket_name>
```

3. Run inventory report
```
gcloud asset export ---out-path=gs://<your_bucket_name>/resource_inventory.json \
	--content-type=resource \ # content types can be the following: resource, iam
	--project=<your_project_id> \ # --folder or --organization can also be used
```

4. Download the Cloud Foundation Toolkit
```
# OS X
curl -o cft https://storage.googleapis.com/cft-cli/latest/cft-darwin-amd64
# Linux
curl -o cft https://storage.googleapis.com/cft-cli/latest/cft-linux-amd64
# executable
chmod +x cft

# Windows
curl -o cft.exe https://storage.googleapis.com/cft-cli/latest/cft-windows-amd64
```

5. Clone this repo

6. RUn the Scorecard
```
./cft scorecard --policy-path=./guardrails/ \
	--bucket=<your_bucket_name>
```
