#!/bin/bash

set -euxo pipefail

# See https://github.com/actions/runner/releases
RUNNER_VERSION="2.289.1"
EXPECTED_SHA256="28e09a31fe35863ef63507494642310eb7cbb9f2ae8c327cfce6962045a106f0"

apt-get update
apt-get install -y apt-transport-https ca-certificates curl gnupg
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo 'deb [arch=arm64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu bionic stable' > /etc/apt/sources.list.d/docker.list

apt-get update
apt-get install -y jq at git docker-ce docker-ce-cli containerd.io openssl libssl-dev pkg-config
usermod -aG docker ubuntu
systemctl enable docker.service
systemctl enable containerd.service

cd /home/ubuntu
mkdir actions-runner && cd actions-runner
curl -fsSLo actions-runner.tar.gz https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-arm64-${RUNNER_VERSION}.tar.gz
echo "$EXPECTED_SHA256 actions-runner.tar.gz" | sha256sum -c
tar xzf actions-runner.tar.gz
rm -f actions-runner.tar.gz
./bin/installdependencies.sh

chown -R ubuntu:ubuntu /home/ubuntu/actions-runner
