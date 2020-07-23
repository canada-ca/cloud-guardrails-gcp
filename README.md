# GC Cloud Guardrails

## Source Links
[Government of Canada Guardrails](https://github.com/canada-ca/cloud-guardrails)

[Cloud Inventory Assets](https://cloud.google.com/asset-inventory/docs/overviewhttps://cloud.google.com/asset-inventory/docs/overview)

[Open Policy Agent](https://www.openpolicyagent.org/)

[conftest](https://www.conftest.dev/)

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
export MY_BUCKET_NAME=<bucket-name>
gsutil mb gs://$MY_BUCKET_NAME
```

3. Run inventory report
```
gcloud asset export --output-path=gs://$MY_BUCKET_NAME/resource_inventory.json \
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

```
./cai-dir/access_policy_inventory.json
--------------------------------------------------------------------------------
PASS: 1/1
WARN: 0/1
FAIL: 0/1

./cai-dir/iam_inventory.json
--------------------------------------------------------------------------------
PASS: 10/10
WARN: 0/10
FAIL: 0/10

./cai-dir/inventory.json
[31mFAIL[0m - //compute.googleapis.com/projects/gke-test-project/regions/asia-east2/subnetworks/default not located in Canada 'asia-east2'
[31mFAIL[0m - //compute.googleapis.com/projects/gke-test-project/regions/asia-south1/subnetworks/default not located in Canada 'asia-south1'
[31mFAIL[0m - //compute.googleapis.com/projects/gke-test-project/regions/asia-southeast1/subnetworks/default not located in Canada 'asia-southeast1'
```