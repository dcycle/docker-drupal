#!/bin/bash
#
# Rebuild script run in Dockerfile.
#
set -e

rm /usr/local/bin/composer
cd /opt
# Download installer and check for its integrity.
curl -sSL https://getcomposer.org/installer > composer-setup.php
curl -sSL https://composer.github.io/installer.sha384sum > composer-setup.sha384sum
sha384sum --check composer-setup.sha384sum
# Install Composer 2 and expose `composer` as a symlink to it.
php composer-setup.php --install-dir=/usr/local/bin --filename=composer2 --2
ln -s /usr/local/bin/composer2 /usr/local/bin/composer
# Install Composer 1, make it point to a different `$COMPOSER_HOME` directory than Composer 2, install `hirak/prestissimo` plugin.
php composer-setup.php --install-dir=/usr/local/bin --filename=.composer1 --1
printf "#!/bin/sh\nCOMPOSER_HOME=\$COMPOSER1_HOME\nexec /usr/local/bin/.composer1 \$@" > /usr/local/bin/composer1
chmod 755 /usr/local/bin/composer1
composer1 global require hirak/prestissimo
# Remove installer files.
rm /opt/composer-setup.php /opt/composer-setup.sha384sum

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
cd /var/www/html && drush -v
