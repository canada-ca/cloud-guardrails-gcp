package main

#This check is to ensure that SSC has the right role and permissions to monitor tenant environement
required_role := "SSC-CloudBroker"
required_permissions := ["dataprocessing.groupcontrols.list","monitoring.dashboards.get","monitoring.groups.get","monitoring.services.get","orgpolicy.policy.get","resourcemanager.projects.get"]
asset_type="iam.googleapis.com/Role"
existing_roles := input.resource.data.title
existing_permissions := input.resource.data.includedPermissions


# Validate role exists
 deny[{"msg": message}] {
  asset_type= input.asset_type
  not required_role == existing_roles
  message :=sprintf("The role '%s' does not exist", [existing_roles])
}


# Validate permissions assigned
 deny[{"msg": message}] {
  asset_type= input.asset_type
  required_role == existing_roles
  not required_permissions == existing_permissions
  message :=sprintf("The permissions '%s' for SSC-Cloudbroker do not exist", [existing_permissions])
}