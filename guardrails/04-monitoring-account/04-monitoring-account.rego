package main

match_roles := "roles/monitoring.viewer"

match_asset := "cloudresourcemanager.googleapis.com/Project"

value_exists (rolebinding, roles){
	rolebinding.role == roles
}

# Users that are allowed to use the above Roles
approvedusers = []

# Validate Role Exists
deny[{"msg": message}] {

    input.data[_].asset_type == match_asset
    rolebinding := input.data[_].iam_policy.bindings[_]

    satisfied := [good | role = match_roles ; good = startswith(rolebinding.role, role)]

    not value_exists(rolebinding, match_roles)

    message := sprintf("Guardrail # 4: The role '%s' does not exist", [match_roles])

}

# Validate User assigned is correct
deny[{"msg": message}] {

    input.asset_type == match_asset

    rolebinding := input.iam_policy.bindings[_]
	users := rolebinding.members[_]
    
    invalid_role(rolebinding, match_roles)
    not containsuser(users, approvedusers)

    message := sprintf("Guardrail # 4: User '%v' is not approved for '%v' role", [users, match_roles])
}