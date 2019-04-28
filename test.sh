#!/bin/bash
# Test this on a continuous integration server.

set -e

docker pull drupal:8
docker pull drupal:7

docker build -f="Dockerfile-7" -t test-drupal-7 .
docker build -f="Dockerfile-8" -t test-drupal-8 .
docker build -f="Dockerfile-8drush9" -t test-drupal-8drush9 .

docker run --rm Dockerfile-7 /bin/bash -c 'ls -lah | grep .htaccess'
docker run --rm Dockerfile-8 /bin/bash -c 'ls -lah | grep .htaccess'
docker run --rm Dockerfile-8drush9 /bin/bash -c 'ls -lah | grep .htaccess'
