package main

has_location(obj, field){
   obj[field]
}


allowedregions = [
   "northamerica-northeast1",
   "global"
]

# List of Resources that will be allowed if they are located outside of the allowed regions
allowedresources = [
   "compute.googleapis.com/Firewall",
   "compute.googleapis.com/Route"
]

deny[{"msg": message}] {

   asset := input.data[_]

   has_location(asset.resource, "location")

   not location_match(asset.resource.location, allowedregions)

   not allowedResource(asset.asset_type)

   message := sprintf("Guardrail # 5: Resource '%v' not located in Canada '%v'", [asset.name, asset.resource.location])
}

allowedResource(resource) {
   resource == allowedresources[_]
}

location_match(str, pattern) {
   contains(str,pattern[_])
}
