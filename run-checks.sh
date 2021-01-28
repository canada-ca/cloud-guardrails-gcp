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

#!/bin/bash

if test -f "report.txt"; then
    rm report.txt
fi
# Process file and run output through conftest
# This is necesary due to gcloud asset export outputting each asset as a json object and not as a list
for file in ./cai-dir/*.json; do
    echo $file >> report.txt
    cat $file | tr '\n' ',' | sed  '1s;^;[\n;' - | sed '$ a ]'  | conftest test -p guardrails - >> report.txt
    printf "\n" >> report.txt
done


