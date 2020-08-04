package main

#This check is to ensure that SSC has the right role and permissions to monitor tenant environement
required_role := "SSC-CloudBroker"
required_permissions := ["dataprocessing.groupcontrols.list","monitoring.dashboards.get","monitoring.groups.get","monitoring.services.get","orgpolicy.policy.get","resourcemanager.projects.get"]
existing_roles := input.resource.data.title
existing_permissions := input.resource.data.includedPermissions


# Validate role exists
 deny[{"msg": message}] {
  required_role == existing_roles
  message :=sprintf("The role '%s' does not exist", [required_role])
}
# Validate permission exists
 deny[{"msg": message}] {
  not required_permissions == existing_permissions
  message :=sprintf("The permissions '%s' doe not exist", [required_permissions])
}