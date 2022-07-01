#!/bin/bash
#
# Step two of the build process common to Alpine and Ubuntu.
#
set -e

echo "===> (9php8) composer install"
mv /composer-file/composer.json /var/www/html/composer.json
cd /var/www/html && composer install
rm -Rf vendor/drush
composer install
ls -lah /var/www/html
cat /var/www/html/core/lib/Drupal.php|grep VERS
ln -s /var/www/html/vendor/bin/drush /bin/drush
drush -v
echo "===> (9php8) All done installing Drupal 9 (php 8)"
/docker-resources/tools/check-integrity.sh "Drupal 9, PHP 8"
