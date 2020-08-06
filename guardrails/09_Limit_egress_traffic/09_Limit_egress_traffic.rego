package main

has_egress(obj, field){
   obj[field]
}

denylist = [
   "0.0.0.0/0"
]

firewall_match(str, pattern) {
   contains(str,pattern[_])
}

deny[{"msg": message}] {

   asset := input.data[_]

   has_egress(asset.resource.data, "destinationRanges")

   firewall_match(asset.resource.data.destinationRanges[0], denylist)

   message := sprintf("Guardrail # 9: Resource '%v' egress allowed range '%v'", [asset.name, asset.resource.data.destinationRanges[0]])
	
}
