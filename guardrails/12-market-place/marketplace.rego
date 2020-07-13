package main

bad_role_name := "roles/cloudprivatecatalogproducer.admin"

invalid_role {
	input.iam_policy.bindings[_].role == bad_role_name
}

deny[{"msg": message}] {

    asset := input
	
    invalid_role
    
    message := sprintf("Resource '%v' has Policy Role Binding '%v' which is not allowed", [asset.name, bad_role_name])
    
}