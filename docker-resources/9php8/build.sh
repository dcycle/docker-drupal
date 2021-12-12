#!/bin/bash
#
# Rebuild script run in Dockerfile.
#
set -e

# See "/var/www/html vs /opt/drupal" in ./README.md
# This code exists in ./Dockerfile-8, ./Dockerfile-8drush, ./Dockerfile-9
rm /var/www/html
rm -rf /opt/drupal
mkdir /var/www/html
chown www-data:www-data /var/www/html
apt-get update
echo "===> apt-get install git, zip"
echo "===> Going through hoops using QEMU/buildx for AMR, see https://forums.linuxmint.com/viewtopic.php?p=1871690"
apt-get install -y --no-install-recommends mariadb-client git zip || true
dpkg --purge --force-all libc-bin
apt-get install -y --no-install-recommends mariadb-client git zip
rm -rf /var/lib/apt/lists/*
mv /composer-file/composer.json /var/www/html/composer.json
cd /var/www/html && composer install
cat /var/www/html/core/lib/Drupal.php|grep VERS
ln -s /var/www/html/vendor/bin/drush /bin/drush
drush -v
