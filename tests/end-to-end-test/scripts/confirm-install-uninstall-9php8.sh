#!/bin/bash
#
# Make sure we can install and uninstal modules.
#
set -e

composer require drupal/token
ls -lah /var/www/html/modules/contrib/token
composer remove drupal/token
