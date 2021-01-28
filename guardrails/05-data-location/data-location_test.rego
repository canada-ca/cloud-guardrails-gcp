################
# Copyright 2021 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#################

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
