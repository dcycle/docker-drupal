#!/bin/bash
#
# Rebuild script run in Dockerfile.
#
set -e

echo "===> (7) Installing libc-bin"
apt-get install -y libc-bin
echo "===> (7) Installing composer"
curl -sS https://getcomposer.org/installer | php
echo "===> (7) Moving composer to the right place"
mv composer.phar /usr/local/bin/composer
echo "===> (7) Require drush 8, the latest version of drush to support Drupal 7"
composer global require drush/drush:~8
echo "===> (7) Symlink to drush command"
ln -s /root/.composer/vendor/drush/drush/drush /bin/drush
echo "===> (7) apt-get update"
apt-get update
echo "===> (7) apt-get install git, zip"
echo "===> Going through hoops using QEMU/buildx for AMR, see https://forums.linuxmint.com/viewtopic.php?p=1871690"
apt-get install -y --no-install-recommends mariadb-client git zip || true
dpkg --purge --force-all libc-bin
apt-get install -y --no-install-recommends mariadb-client git zip
echo "===> (7) rm -rf /var/lib/apt/lists/* to save space"
rm -rf /var/lib/apt/lists/*
echo "===> (7) creating /var/www/latest-drupal and downloading drupal 7 therein"
mkdir /var/www/latest-drupal
cd /var/www/latest-drupal
drush dl drupal-7
echo "===> (7) moving drush 7 to /var/www/html"
cp -r /var/www/latest-drupal/drupal-*/* /var/www/html
echo "===> (7) All done installing Drupal 7"
