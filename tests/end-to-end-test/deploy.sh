#!/bin/bash
#
# Deploy an environment.
#
set -e

if [ -z "$1" ]; then
  >&2 echo "Please provide an argument such as 7 or 10"
  exit 1
fi

docker compose \
  -f docker-compose.yml \
  -f docker-compose."$1".yml \
  down -v
docker compose \
  -f docker-compose.yml \
  -f docker-compose."$1".yml \
  up -d --build
docker compose ps
docker compose exec -T drupal /bin/bash -c "/docker-resources/deploy.sh $1"
