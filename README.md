# GC Cloud Guardrails Checks for Google Cloud Platform

This repository will provide the tools required to validate the minimum guardrails for the GC Cloud Operationalization Framework for Google Cloud Platform

## Guardrails

| Guardrail | Description | Enforcement | Link |
|----|----|----| --- |
| 01 Protect Root / Global Admins Account | | Doc | [link](./guardrails/guardrail-1-mfa.md)  |
| 02 Management of Administrative Privileges | | Doc | [link]()   |
| 03 Cloud Console Access | | Doc | [link]()  |
| 04 Enterprise Monitoring Accounts | | Rego | [link](guardrails/04-monitoring-account/04-monitoring-account.rego) |
| 05 Data Location | | Rego | [link](guardrails/05-data-location/guardrail-6-data-location.md) |
| 06 Protection of Data-At-Rest | | Doc | [link](./guardrails/guardrail-6-at-rest.md) |
| 07 Protection of Data-In-Transit | | Doc | [link](./guardrails/guardrail-7-in-transit.md) |
| 08 Segment and Separate | | Rego | [link](guardrails/06-segment-and-separate/guardrail-8-segment-seperate.md) |
| 09 Network Security Services | | Rego | [Link](guardrails/09-network-security-services/guardrail-9-network-security-services.md) |
| 10 Cyber Defence Services | | MOU |
| 11 Logging and Monitoring | | Rego | [Link](guardrails/11-logging-and-monitoring/11-Logging-and-Monitoring.rego) |
| 12 Configuration of Cloud Marketplaces | | Rego | [Link](guardrails/12-market-place/guardrail-12-marketplace) |

## GC Guardrails Accelerator Templates

See [gc guardrails accelerator gcp](https://github.com/canada-ca/accelerators_accelerateurs-gcp)

## GC Guardrails Validation

Makes use of [Open Policy Agent](https://www.openpolicyagent.org/) and GCP's [Asset Invetory API](https://cloud.google.com/asset-inventory) to validate compliance of deployed resources.

See [documentation](guardrails-check/README.md)