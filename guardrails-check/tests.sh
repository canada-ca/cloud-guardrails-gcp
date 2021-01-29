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

# Download conftest if not installed
if ! conftest --version &> /dev/null
then
	apt update && apt upgrade
	apt install -y wget
	echo "Installing conftest"
	wget https://github.com/open-policy-agent/conftest/releases/download/v0.20.0/conftest_0.20.0_Linux_x86_64.tar.gz
	tar xzf conftest_0.20.0_Linux_x86_64.tar.gz
	mv conftest /usr/local/bin
fi

# Testing rego
echo "Testing Policies"
for guardrail in guardrails/*; do
	if [ -d "$guardrail" ]; then
		echo $guardrail
		conftest verify -p $guardrail
	fi
done
