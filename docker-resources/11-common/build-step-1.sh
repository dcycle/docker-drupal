#!/bin/bash
#
# Step one of the build process common to Alpine and Ubuntu.
#
set -e

mkdir -p /composer-file
cp /docker-resources/11-common/composer.json /composer-file/composer.json
rm /var/www/html
rm -rf /opt/drupal
mkdir /var/www/html
chown www-data:www-data /var/www/html
