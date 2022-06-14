VERSION="$1"

echo "*************"
echo "** TEST IMAGE $VERSION"
echo "*************"

echo ' => working directory'
docker run --rm "test-drupal-$VERSION" /bin/bash -c 'pwd'
echo ' => listing contents'
docker run --rm "test-drupal-$VERSION" /bin/bash -c 'ls -lah'
echo ' => make sure .htaccess exists'
docker run --rm "test-drupal-$VERSION" /bin/bash -c "ls -lah | grep .htaccess"
echo ' => make sure drush works'
docker run --rm "test-drupal-$VERSION" /bin/bash -c "drush status"
echo ' => launch a dummy Drupal site'
cd ./tests/end-to-end-test
echo ' => about to create dummy .env file with pseudo-random password and hash'
echo "" > .env
# Using RANDOM for testing purposes only. Use a strong random string generator
# in your production sites.
echo "MARIADB_ROOT_PASSWORD="$RANDOM$RANDOM$RANDOM$RANDOM >> .env
echo "HASH_SALT="$RANDOM$RANDOM$RANDOM$RANDOM >> .env
echo ' => created dummy .env file'
cat .env
echo " => about to deploy $VERSION"
./deploy.sh "$VERSION"
echo " => just deployed $VERSION"
echo " => make sure drush uli works"
docker-compose exec drupal /bin/bash -c 'drush uli'
echo " => about to destroy $VERSION"
./destroy.sh
echo " => just destroyed $VERSION"
echo " => cd back where we were"
cd -
echo " => Done with smoke tests on $VERSION!"
echo " =>"
