#!/bin/bash
# Rebuild script
# This is meant to be run on a regular basis after the Wednesdays security
# window, to rebuild the images with the latest security features.

set -e

./test.sh

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
source ./scripts/lib/rebuild-version.sh 7 7
source ./scripts/lib/rebuild-version.sh 9php8 9
