# GC Cloud Guardrails

## Source Links
[Cloud Foundation Scorcard](https://github.com/GoogleCloudPlatform/cloud-foundation-toolkit/blob/master/cli/docs/scorecard.mdhttps://github.com/GoogleCloudPlatform/cloud-foundation-toolkit/blob/master/cli/docs/scorecard.md)

[Cloud Inventory Assets](https://cloud.google.com/asset-inventory/docs/overviewhttps://cloud.google.com/asset-inventory/docs/overview)

## Permissions
- Cloud Asset Viewer
- Service Usage Consumer

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
gcloud asset export ---output-path=gs://<your_bucket_name>/resource_inventory.json \
	--content-type=resource \ # content types can be the following: resource, iam-policy, access-policy, org-policy
	--project=<your_project_id> \ # --folder or --organization can also be used
```

4. Download [Conftest](https://www.conftest.dev/)

```
# Linux
$ wget https://github.com/open-policy-agent/conftest/releases/download/v0.17.1/conftest_0.17.1_Linux_x86_64.tar.gz
$ tar xzf conftest_0.17.1_Linux_x86_64.tar.gz
$ sudo mv conftest /usr/local/bin
```
Installation process for other [OSes](https://www.conftest.dev/install/)

5. Clone this repo

6. Copy files from google storage to your location disk
```
gsutil cp gs://<your_bucket_name>/resource_inventory.json ./cai-dir
```

6. Run the Tests
```
./format.sh
```

This will format the output from the inventory dump and run the tests. Results will be placed in the report.txt folder in the current directory.

example output