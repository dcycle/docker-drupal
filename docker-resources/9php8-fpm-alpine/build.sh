#!/bin/bash
#
# Rebuild script run in Dockerfile for Alpine.
#
set -e

/docker-resources/9php8-common/build-step-1.sh

echo "===> (9php8) apk add --no-cache mariadb-client git zip"

apk add --no-cache mariadb-client git zip

/docker-resources/9php8-common/build-step-2.sh
