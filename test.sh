#!/bin/bash
# Test this on a continuous integration server.

set -e

docker pull drupal:8
docker pull drupal:8drush9
docker pull drupal:7

docker build -f="Dockerfile-7" -t test-drupal-7 .
docker build -f="Dockerfile-8" -t test-drupal-8 .
docker build -f="Dockerfile-8drush9" -t test-drupal-8drush9 .
docker build -f="Dockerfile-8drush10" -t test-drupal-8drush10 .

docker run --rm test-drupal-7 /bin/bash -c 'ls -lah | grep .htaccess'
docker run --rm test-drupal-8 /bin/bash -c 'ls -lah | grep .htaccess'
docker run --rm test-drupal-8drush9 /bin/bash -c 'ls -lah | grep .htaccess'
docker run --rm test-drupal-8drush10 /bin/bash -c 'ls -lah | grep .htaccess'
