package main

has_location(obj, field){
    obj[field]
}

allowlist = [
    "northamerica-northesst1",
    "global"
]

deny[{"msg": message}] {

    # has_location(input.resource, "location")

    asset := input
    not location_match(asset.resource.location, allowlist)

    message := sprintf("%v not located in Canada '%v'", [asset.name, asset.resource.location])
}

location_match(str, pattern) {
    contains(str,pattern[_])
}