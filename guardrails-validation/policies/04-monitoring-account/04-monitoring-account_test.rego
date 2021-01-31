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


