<?php
$databases['default']['default'] = array(
  'driver' => 'mysql',
  'database' => 'drupal',
  'username' => 'root',
  'password' => getenv('MARIADB_ROOT_PASSWORD'),
  'host' => 'mysql',
  'prefix' => '',
);
