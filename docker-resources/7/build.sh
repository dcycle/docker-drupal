#!/bin/bash
#
# Rebuild script run in Dockerfile.
#
set -e

echo "===> Installing libc-bin"
apt-get install -y libc-bin
echo "===> Installing composer"
curl -sS https://getcomposer.org/installer | php
echo "===> Moving composer to the right place"
mv composer.phar /usr/local/bin/composer
echo "===> Require drush 8, the latest version of drush to support Drupal 7"
composer global require drush/drush:~8
echo "===> Symlink to drush command"
ln -s /root/.composer/vendor/drush/drush/drush /bin/drush
echo "===> apt-get update"
apt-get update
echo "===> apt-get install git, zip"
apt-get install -y --no-install-recommends mariadb-client git zip
echo "===> rm -rf /var/lib/apt/lists/* to save space"
rm -rf /var/lib/apt/lists/*
echo "===> creating /var/www/latest-drupal and downloading drupal 7 therein"
mkdir /var/www/latest-drupal
cd /var/www/latest-drupal
drush dl drupal-7
echo "===> moving drush 7 to /var/www/html"
cp -r /var/www/latest-drupal/drupal-*/* /var/www/html
echo "===> All done installing Drupal 7"
