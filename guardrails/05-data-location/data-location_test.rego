package main

test_correct_location {
    input := {"data":[
        {   
            "asset_type": "service.googleapis.com/Object",
            "name": "test-role",
            "resource": {
                    "title": "Generic-Cloud Resource",
		    "location": "northamerica-northeast1"
                   
            }   
        }   
    ]}  

    results := deny with input as input
    count(results) == 0
}


test_incorrect_location {

    input := {"data":[
        {   
            "asset_type": "service.googleapis.com/Object",
            "name": "test-role",
            "resource": {
                    "title": "Generic-Cloud Resource",
                    "location": "incorrect-region"
                        
            }   
        }   
    ]}

   results := deny with input as input
   count(results) == 1

}

test_allowed_resources {

  input := {"data": [
           {
             "asset_type": "compute.googleapis.com/IncorrectResource",
             "name": "test_services",
             "resource": {
                 "title": "Generic-Cloud Resource",
                 "location": "correct-region"
             }
           }
  ]}

  results := deny with input as input
  count(results) == 1 

}
