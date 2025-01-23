#!/bin/bash
#
# Rebuild script run in Dockerfile for Alpine.
#
set -e

/docker-resources/11-fpm-alpine/build.sh

# Make sure opcache is disabled during development so that our changes
# to PHP are reflected immediately.
echo 'opcache.enable=0' >> /usr/local/etc/php/php.ini

# Install Xdebug
# See https://matthewsetter.com/setup-step-debugging-php-xdebug3-docker/
# https://github.com/docker-library/php/issues/412#issuecomment-297170197
# https://stackoverflow.com/questions/46825502/how-do-i-install-xdebug-on-dockers-official-php-fpm-alpine-image
# linux-headers required to prevent "error: rtnetlink.h is required"
apk add --no-cache --virtual .build-deps --update \
  linux-headers autoconf $PHPIZE_DEPS
pecl install xdebug
docker-php-ext-enable xdebug
apk del -f .build-deps

echo "xdebug.start_with_request=trigger" >> /usr/local/etc/php/conf.d/xdebug.ini
echo "xdebug.mode=profile" >> /usr/local/etc/php/conf.d/xdebug.ini
