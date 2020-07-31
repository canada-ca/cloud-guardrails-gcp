package main

# Dissallow Private Catalog Admin to prevent it being used by unauthorized users
# With this permission users can create private catalogs for the GCP workspace
bad_roles := [
    "roles/cloudprivatecatalogproducer.admin"
]

# Users that are allowed to use the above Roles
allowedusers = []

# Does the role binding mastch the disallowed role
invalid_role (rolebinding, roles){
	rolebinding.role == roles[_]
}

# Checks Members list for matching pattern
containsuser (users, pattern) {
    contains(users,pattern[_])
}

deny[{"msg": message}] {

    rolebinding := input.iam_policy.bindings[_]
	users := rolebinding.members[_]
    
    invalid_role(rolebinding, bad_roles)
    not containsuser(users, allowedusers)

    message := sprintf("Guardrail # 11: Resource '%v' has Policy Role Binding '%v' on Member '%v' which is not allowed", [input.name, bad_roles, users])
    
}
