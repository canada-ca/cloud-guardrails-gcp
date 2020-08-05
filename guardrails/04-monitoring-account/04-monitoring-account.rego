package main

#This check is to ensure that SSC has the right role and permissions to monitor tenant environement
required_role := "SSC-CloudBroker"
required_permissions := ["dataprocessing.groupcontrols.list","monitoring.dashboards.get","monitoring.groups.get","monitoring.services.get","orgpolicy.policy.get","resourcemanager.projects.get"]
asset_type="iam.googleapis.com/Role"



# Validate role exists
 deny[{"msg": message}] {
 
  asset := input.data
  asset_type = asset[_].asset_type
  asset_type == "iam.googleapis.com/Role"
  
  not evaluateRole(asset)
  message :=sprintf("Guardrail # 4: The role '%s' does not exist", [required_role])
}

evaluateRole(asset){
  required_role == asset[_].resource.data.title
}

# Validate permissions assigned
 deny[{"msg": message}] {
  asset := input.data[_]

  existing_roles := asset.resource.data.title
  existing_roles == required_role
  

  existing_permissions := asset.resource.data.includedPermissions

  required_role == existing_roles
  not required_permissions == existing_permissions
  
  message :=sprintf("Guardrail # 4: The permissions for '%v' do not match, expected '%v' but got '%v'", [existing_roles, required_permissions, existing_permissions])
}

