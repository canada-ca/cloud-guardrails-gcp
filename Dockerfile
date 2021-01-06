FROM debian:bullseye-slim

WORKDIR /app

ENV CONFTEST_VERSION=0.21.0
COPY run.sh ./run.sh

RUN apt update && apt install -y wget && wget https://github.com/open-policy-agent/conftest/releases/download/v${CONFTEST_VERSION}/conftest_${CONFTEST_VERSION}_Linux_x86_64.tar.gz && \
tar -xvf conftest*.tar.gz && \
mv conftest /usr/local/bin

ENTRYPOINT ./run.sh
