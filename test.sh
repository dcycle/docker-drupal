#!/bin/bash
# Test this on a continuous integration server.

set -e

docker pull drupal:8
docker pull drupal:7

echo "Testing Dockerfile-7"
docker build -f="Dockerfile-7" -t test-drupal-7 .
echo "Testing Dockerfile-8"
docker build -f="Dockerfile-8" -t test-drupal-8 .
echo "Testing Dockerfile-8drush9"
docker build -f="Dockerfile-8drush9" -t test-drupal-8drush9 .
echo "Testing Dockerfile-8drush"
docker build -f="Dockerfile-8drush" -t test-drupal-8drush .
echo "Testing Dockerfile-9"
docker build -f="Dockerfile-9" -t test-drupal-9 .

source ./scripts/lib/smoke-test.sh test-drupal-7 .
source ./scripts/lib/smoke-test.sh test-drupal-8 .
source ./scripts/lib/smoke-test.sh test-drupal-8drush9 web
source ./scripts/lib/smoke-test.sh test-drupal-8drush web
source ./scripts/lib/smoke-test.sh test-drupal-9 web
