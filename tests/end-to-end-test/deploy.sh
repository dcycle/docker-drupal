#!/bin/bash
#
# Deploy an environment.
#
set -e

docker-compose \
  -f docker-compose.yml \
  -f docker-compose."$1".yml \
  up -d --build
docker-compose exec -T drupal /bin/bash -c '/docker-resources/deploy.sh'
