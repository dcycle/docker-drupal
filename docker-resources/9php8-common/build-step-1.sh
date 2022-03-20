#!/bin/bash
#
# Step one of the build process common to Alpine and Ubuntu.
#
set -e

mkdir -p /composer-file
cp /docker-resources/9php8-common/composer.json /composer-file/composer.json
# See "/var/www/html vs /opt/drupal" in ./README.md
# This code exists in ./Dockerfile-8, ./Dockerfile-8drush, ./Dockerfile-9
rm /var/www/html
rm -rf /opt/drupal
mkdir /var/www/html
chown www-data:www-data /var/www/html
