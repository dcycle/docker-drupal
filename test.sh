#!/bin/bash
#
# Test this on a continuous integration server.
#
set -e

docker pull drupal:10.0-rc-php8.1-fpm-alpine
docker pull drupal:7

echo "Testing Dockerfile-7"
docker build -f="Dockerfile-7" -t test-drupal-7 .
echo "Testing Dockerfile-7php8"
docker build -f="Dockerfile-7php8" -t test-drupal-7php8 .
echo "Testing Dockerfile-10-fpm-alpine"
docker build -f="Dockerfile-10-fpm-alpine" -t test-drupal-10-fpm-alpine .
echo "Testing Dockerfile-10-fpm-alpine-dev"
docker build -f="Dockerfile-10-fpm-alpine-dev" -t test-drupal-10-fpm-alpine-dev .

./scripts/lib/test.sh 7
./scripts/lib/test.sh 7php8
./scripts/lib/test.sh 10

echo ""
echo "Done with all continuous integration tests, your code should be good to go!!!"
echo ""
