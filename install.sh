#!/bin/bash

export CONFTEST_VERSION=0.21.0

wget https://github.com/open-policy-agent/conftest/releases/download/v${CONFTEST_VERSION}/conftest_${CONFTEST_VERSION}_Linux_x86_64.tar.gz && \
mkdir conftest && \
tar -xvf conftest*.tar.gz --directory conftest && \
sudo mv conftest/conftest /usr/local/bin

# Clean Up
rm -rf conftest conftest_${CONFTEST_VERSION}_Linux_x86_64.tar.gz
