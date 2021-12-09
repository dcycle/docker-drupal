#!/bin/bash
#
# Rebuild script run in Dockerfile.
#
set -e

curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
composer global require drush/drush:~8
ln -s /root/.composer/vendor/drush/drush/drush /bin/drush
apt-get update
apt-get install -y --no-install-recommends mariadb-client git zip
rm -rf /var/lib/apt/lists/*
mkdir /var/www/latest-drupal
cd /var/www/latest-drupal
drush dl drupal-7
cp -r /var/www/latest-drupal/drupal-*/* /var/www/html
