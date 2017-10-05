#!/bin/bash
# Rebuild script
# This is meant to be run on a regular basis, daily or twice daily,
# to rebuild the image with the latest security features.

set -e

CREDENTIALS="$HOME/.dcycle-docker-credentials.sh"

if [ ! -f "$CREDENTIALS" ]; then
  echo "Please create $CREDENTIALS and add to it:"
  echo "DOCKERHUBUSER=xxx"
  echo "DOCKERHUBPASS=xxx"
  exit;
else
  source "$CREDENTIALS";
fi

DATE=`date '+%Y-%m-%d-%H-%M-%S-%Z'`
# Rebuild the entire thing because there may be security updates
# since the last build.
# Start by getting the latest version of the official drupal image
docker pull drupal:8
# Rebuild the entire thing
docker build --no-cache -t dcycle/drupal:8 .
docker build -t dcycle/drupal:8.$DATE .
docker login -u"$DOCKERHUBUSER" -p"$DOCKERHUBPASS"
docker push dcycle/drupal:8
docker push dcycle/drupal:8."$DATE"
