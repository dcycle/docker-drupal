#!/bin/bash
#
# This script is run when the Drupal docker container is ready. It prepares
# an environment for development or testing, which contains a full Drupal
# 8 installation with a running website and our custom modules.
#
set -e

if [ -z "$1" ]; then
  >&2 echo "Please provide an argument such as 10-fpm-alpine or 11"
  exit 1
fi
VERSION="$1"

if [ -z "$MARIADB_ROOT_PASSWORD" ]; then
  >&2 echo 'MARIADB_ROOT_PASSWORD should always be set; please destroy your'
  >&2 echo 'environment using "docker compose down -v", then restart it'
  >&2 echo 'using ./scripts/deploy.sh, which should create a password in'
  >&2 echo 'the ./.env file.'
  exit 2;
fi

echo "Will try to connect to MySQL container until it is up. This can take up to 15 seconds if the container has just been spun up."
OUTPUT="ERROR"
TRIES=30
for i in `seq 1 "$TRIES"`;
do
  OUTPUT=$(echo 'show databases'|{ mariadb -h mysql -u root --password="$MARIADB_ROOT_PASSWORD" 2>&1 || true; })
  if [[ "$OUTPUT" == *"ERROR"* ]]; then
    if [ "$i" == "$TRIES" ];then
      echo "MySQL container after $TRIES tries, with error $OUTPUT. Abandoning. We suggest you reset Docker to factory defaults, then give Docker 6Gb instead of 2Gb RAM in the Resources section of the preferences pane, and try again. If you are still getting an error please open a ticket at https://github.com/dcycle/starterkit-drupal8site/issues with this message and any other information about your environment."
      echo "About to exit with code 1."
      exit 1
    else
      echo "Try $i of $TRIES. MySQL container is not available yet. Should not be long..."
      echo "$OUTPUT"
      sleep 1
    fi
  else
    echo "MySQL is up! Moving on..."
    break
  fi
done

OUTPUT=$(echo 'select * from users limit 1'|{ mysql --user=root --password="$MARIADB_ROOT_PASSWORD" --database=drupal --host=mysql 2>&1 || true; })
if [[ "$OUTPUT" == *"ERROR"* ]]; then
  echo "Installing Drupal $VERSION because we did not find an entry in the users table."
  cp sites/default/default.settings.php sites/default/settings.php
  echo "require('/docker-resources/local-settings.php');" >> sites/default/settings.php
  drush status
  drush si -vvv -y
  echo "Done installing Drupal."
else
  echo "Assuming Drupal is already running, because there is a users table with at least one entry."
fi

drush uli
