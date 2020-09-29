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
   "compute.googleapis.com/Route",
   "compute.googleapis.com/Network",
   "compute.googleapis.com/Subnetwork",
   "compute.googleapis.com/Project",
   "cloudkms.googleapis.com/CryptoKey",
   "cloudkms.googleapis.com/KeyRing",
   "cloudkms.googleapis.com/CryptoKeyVersion"
]

deny[{"msg": message}] {

   asset := input.data[_]

   has_location(asset.resource, "location")

   not location_match(asset.resource.location, allowedregions)

   not allowedResource(asset.asset_type)

   message := sprintf("Guardrail # 5: Resource %v ('%v') is located in '%v' when it is required to be in '%v'", [asset.asset_type, asset.name, asset.resource.location, allowedregions])
}

allowedResource(resource) {
   resource == allowedresources[_]
}

location_match(str, pattern) {
   contains(str,pattern[_])
}
