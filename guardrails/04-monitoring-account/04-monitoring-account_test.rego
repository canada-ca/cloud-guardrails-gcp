package main

test_broker_w_perms_exists {
    input := {"data":[
        {
            "asset_type": "iam.googleapis.com/Role",
            "name": "test-role",
            "resource": {
                "data": {
                    "name": "log-history",
                    "includedPermissions": [
                        "dataprocessing.groupcontrols.list",
                        "monitoring.dashboards.get",
                        "monitoring.groups.get",
                        "monitoring.services.get",
                        "orgpolicy.policy.get",
                        "resourcemanager.projects.get"
                    ],
		    "title": "SSC-CloudBroker"
                }
            }
        }
    ]}

    results := deny with input as input
    count(results) == 0
}

test_broker_does_not_exist {

    input := {"data":[
        {   
            "asset_type": "iam.googleapis.com/Role",
            "name": "test-role",
            "resource": {
                "data": {
                    "name": "log-history",
                    "includedPermissions": [
                        "dataprocessing.groupcontrols.list",
                        "monitoring.dashboards.get",
                        "monitoring.groups.get",
                        "monitoring.services.get",
                        "orgpolicy.policy.get",
                        "resourcemanager.projects.get"
                    ],  
                    "title": "non-compliant-broker"
                }   
            }   
        }   
    ]}

    results := deny with input as input
    count(results) == 1

}


test_incorrect_permissions {

    input := {"data":[
        {   
            "asset_type": "iam.googleapis.com/Role",
            "name": "test-role",
            "resource": {
                "data": {
                    "name": "log-history",
                    "includedPermissions": [
                        "iam.an.incorrect.permission"
                    ],  
                    "title": "SSC_CloudBroker"
                }   
            }   
        }   
    ]}  

    results := deny with input as input
    count(results) == 1

}

test_missing_broker_permissions {

    input := {"data":[
        {   
            "asset_type": "iam.googleapis.com/Role",
            "name": "test-role",
            "resource": {
                "data": {
                    "name": "log-history",
                    "includedPermissions": [
                        "monitoring.services.get",
                        "orgpolicy.policy.get",
                        "resourcemanager.projects.get"
                    ],  
                    "title": "non-compliant-broker"
                }   
            }   
        }   
    ]}  

    results := deny with input as input
    count(results) == 1 

}


