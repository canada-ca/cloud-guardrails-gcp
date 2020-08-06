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
echo "Testing Policies
for guardrail in guardrails/*; do
	if [ -d $guardrail ]; then
		echo $guardrail
		conftest verify -p $guardrail
	fi
done
