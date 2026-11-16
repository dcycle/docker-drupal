#!/bin/bash
#
# Step two of the build process common to Alpine and Ubuntu.
#
set -e

echo "===> (12) composer install"
mv /composer-file/composer.json /var/www/html/composer.json
cd /var/www/html && \
  composer config --no-plugins allow-plugins.php-http/discovery true && \
  composer install
rm -Rf vendor/drush
composer install
ls -lah /var/www/html

ls -lah /var/www/html/vendor/bin/drush

cat /var/www/html/core/lib/Drupal.php|grep VERS
# ln -s /var/www/html/vendor/bin/drush /bin/drush

composer show drush/drush
php /var/www/html/vendor/bin/drush --version
php /var/www/html/vendor/bin/drush status


/var/www/html/vendor/bin/drush --version

echo "===> (12) All done installing Drupal 12.0.0-beta2"
/docker-resources/tools/check-integrity.sh "Drupal 12.0.0-beta2"
