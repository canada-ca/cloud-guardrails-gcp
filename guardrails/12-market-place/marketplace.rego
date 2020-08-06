package main

# Dissallow Private Catalog Admin to prevent it being used by unauthorized users
# With this permission users can create private catalogs for the GCP workspace
bad_roles = ["roles/cloudprivatecatalogproducer.admin"]

deny[{"msg": message}] {

	asset := input.data[_]
    rolebinding := asset.iam_policy.bindings
    roles := bad_roles
    invalid_role(rolebinding, roles)

    message := sprintf("Guardrail # 12: Resource '%v' has Policy Role Binding '%v'", [asset.name, bad_roles])
    
}

# Users that are allowed to use the above Roles
allowedusers = []

# Does the role binding mastch the disallowed role
invalid_role (rolebinding, roles){
        rolebinding[_].role == roles[_]
}

# Checks Members list for matching pattern
containsuser (users, pattern) {
    contains(users,pattern[_])
}
