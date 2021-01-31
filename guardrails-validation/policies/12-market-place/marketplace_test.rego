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
