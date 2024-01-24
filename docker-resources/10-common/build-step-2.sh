#!/bin/bash
#
# Step two of the build process common to Alpine and Ubuntu.
#
set -e

echo "===> (10) composer install"
ls -lah
composer config --no-plugins allow-plugins.php-http/discovery true
mv /composer-file/composer.json /var/www/html/composer.json
cd /var/www/html && composer install
rm -Rf vendor/drush
composer install
ls -lah /var/www/html
cat /var/www/html/core/lib/Drupal.php|grep VERS
ln -s /var/www/html/vendor/bin/drush /bin/drush
drush -v
echo "===> (10) All done installing Drupal 10"
/docker-resources/tools/check-integrity.sh "Drupal 10"
