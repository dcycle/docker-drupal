#!/bin/bash
#
# Rebuild script run in Dockerfile.
#
set -e

mkdir -p /composer-file
cp /docker-resources/9php8/composer.json /composer-file/composer.json
# See "/var/www/html vs /opt/drupal" in ./README.md
# This code exists in ./Dockerfile-8, ./Dockerfile-8drush, ./Dockerfile-9
rm /var/www/html
rm -rf /opt/drupal
mkdir /var/www/html
chown www-data:www-data /var/www/html
apt-get update
echo "===> (9php8) apt-get install mariadb-client git zip"
apt-get install -y --no-install-recommends mariadb-client git zip
rm -rf /var/lib/apt/lists/*
echo "===> (9php8) composer install"
mv /composer-file/composer.json /var/www/html/composer.json
cd /var/www/html && composer install
cat /var/www/html/core/lib/Drupal.php|grep VERS
ln -s /var/www/html/vendor/bin/drush /bin/drush
drush -v
echo "===> (9php8) All done installing Drupal 9 (php 8)"
/docker-resources/tools/check-integrity.sh "Drupal 9, PHP 8"
