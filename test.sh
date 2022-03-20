#!/bin/bash
#
# Test this on a continuous integration server.
#
set -e

docker pull drupal:9
docker pull drupal:7

echo "Testing Dockerfile-7"
docker build -f="Dockerfile-7" -t test-drupal-7 .
echo "Testing Dockerfile-9php8"
docker build -f="Dockerfile-9php8" -t test-drupal-9php8 .

source ./scripts/lib/test.sh 7
source ./scripts/lib/test.sh 9php8
