#!/bin/bash
# Rebuild script
# This is meant to be run on a regular basis after the Wednesdays security
# window, to rebuild the images with the latest security features.

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

if [ ! -d prepare-docker-buildx ]; then
  # See https://github.com/dcycle/prepare-docker-buildx, for M1 native images.
  git clone https://github.com/dcycle/prepare-docker-buildx.git
  cd prepare-docker-buildx
  export DOCKER_CLI_EXPERIMENTAL=enabled
  ./scripts/run.sh
  cd ..

  docker buildx create --name mybuilder
  docker buildx use mybuilder
  docker buildx inspect --bootstrap
  docker login -u"$DOCKERHUBUSER" -p"$DOCKERHUBPASS"
fi

# Rebuild the entire thing because there may be security updates
# since the last build.
# source ./scripts/lib/rebuild-version.sh 7 7 linux/amd64,linux/arm64/v8
# source ./scripts/lib/rebuild-version.sh 9 8 linux/amd64,linux/arm64/v8
# source ./scripts/lib/rebuild-version.sh 9php8 9 linux/amd64,linux/arm64/v8
# source ./scripts/lib/rebuild-version.sh 9php8 9 linux/amd64
source ./scripts/lib/rebuild-version.sh 9 8 linux/arm64/v8
