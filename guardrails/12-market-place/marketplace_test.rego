package main

test_monitoring_account_exists {

    input := {"data":[
        {   
            "asset_type": "iam.googleapis.com/Role",
            "name": "test-role",
            "iam_policy": {
              "bindings": [
		{
                 "members": "test",
		 "role": "roles/cloudprivatecatalogproducer.admin"
                }
	      ]
	    }
        }   
    ]}  


   results := deny with input as input
   count(results) == 1 

}


test_incorrect_role {

    input := {"data":[
        {   
            "asset_type": "iam.googleapis.com/Role",
            "name": "test-role",
            "iam_policy": {
              "bindings": [
                {   
                 "members": "test",
                 "role": "roles/cloudprivatecatalogproducer.incorrect"
                }   
              ]   
            }   
        }   
    ]}  

   results := deny with input as input
   count(results) == 0


}
