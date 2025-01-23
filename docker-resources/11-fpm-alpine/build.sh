#!/bin/bash
#
# Rebuild script run in Dockerfile for Alpine.
#
set -e

/docker-resources/11-common/build-step-1.sh

echo "===> (10) apk add --no-cache mariadb-client git zip"

apk add --no-cache mariadb-client git zip patch

/docker-resources/11-common/build-step-2.sh
