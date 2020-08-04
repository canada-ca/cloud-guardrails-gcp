package main

has_location(obj, field){
   obj[field]
}

allowlist = [
   "northamerica-northeast1",
   "global"
]

allowedresource = [
   "resourcemanager",
   "bigquery"
]

deny[{"msg": message}] {

   asset := input.data[_]

   has_location(asset.resource, "location")

   not location_match(asset.resource.location, allowlist)

   message := sprintf("Guardrail # 5: Resource '%v' not located in Canada '%v'", [asset.name, asset.resource.location])
}

location_match(str, pattern) {
   contains(str,pattern[_])
}
