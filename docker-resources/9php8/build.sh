#!/bin/bash
#
# Rebuild script run in Dockerfile for Ubuntu.
#
set -e

/docker-resources/9php8-common/build-step-1.sh

echo "===> (9php8) apt-get install mariadb-client git zip"

apt-get update
apt-get install -y --no-install-recommends mariadb-client git zip
rm -rf /var/lib/apt/lists/*

/docker-resources/9php8-common/build-step-2.sh
