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

# This will check that log sink exists to save the logs auditing and monitoring
# the example below uses name "log_sink", change this name to match the existing name

empty(value) {
  count(value) == 0
}

no_violations {
  empty(deny)
}

test_bucket_exists {
    input := {"data":[
        {
            "asset_type": "storage.googleapis.com/Bucket",
            "name": "test-bucket",
            "resource": {
                "data": {
                    "name": "log-history"
                }
            }
        },
        {
            "asset_type": "logging.googleapis.com/LogSink",
            "name": "log-sink",
            "resource": {
                "data": {
                    "name": "log_sink"
                }
            }
        }
    ]}

    no_violations with input as input
}

test_bucket_not_exists {
    input := {"data":[
        {
            "asset_type": "storage.googleapis.com/Bucket",
            "name": "test-bucket",
            "resource": {
                "data": {
                    "name": "log-history-does-not-exist"
                }
            }
        },
        {
            "asset_type": "logging.googleapis.com/LogSink",
            "name": "log-sink",
            "resource": {
                "data": {
                    "name": "log_sink"
                }
            }
        }
    ]}

    results := deny with input as input
    count(results) == 1
}

test_logsink_not_exists {
    input := {"data":[
        {
            "asset_type": "storage.googleapis.com/Bucket",
            "name": "test-bucket",
            "resource": {
                "data": {
                    "name": "log-history"
                }
            }
        },
        {
            "asset_type": "logging.googleapis.com/LogSink",
            "name": "log-sink",
            "resource": {
                "data": {
                    "name": "log_sink_not_found"
                }
            }
        }
    ]}

    results := deny with input as input
    count(results) == 1
}

test_logsink_and_bucket_not_exists {
    input := {"data":[
        {
            "asset_type": "storage.googleapis.com/Bucket",
            "name": "test-bucket",
            "resource": {
                "data": {
                    "name": "log-history_not_found"
                }
            }
        },
        {
            "asset_type": "logging.googleapis.com/LogSink",
            "name": "log-sink",
            "resource": {
                "data": {
                    "name": "log_sink_not_found"
                }
            }
        }
    ]}

    results := deny with input as input
    count(results) == 2
}