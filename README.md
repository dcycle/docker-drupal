[![CircleCI](https://circleci.com/gh/dcycle/docker-drupal.svg?style=svg)](https://circleci.com/gh/dcycle/docker-drupal)

A Drupal+Drush Docker image, updated Wednesdays
-----

This image was created for two reasons:

 * [The "official" Drupal Docker image](https://hub.docker.com/_/drupal/) does not have Drush.
 * It takes a few days for it be updated after major security releases.

How security updates are managed
-----

We have a Jenkins server which attempts to rebuild the image wednesdays around 4pm EDT after the security updates are released. Users of this image are also encouraged to rebuild daily.

The jenkins schedule is:

    TZ=America/Montreal
    H 16 * * 3

16 is the time, 3 is the day (Wednesday).

See [this image on the Docker Hub](https://hub.docker.com/r/dcycle/drupal/).

/var/www/html vs /opt/drupal
-----

This project is based on [the "official" Drupal Docker image](https://hub.docker.com/_/drupal/), which, in [this pull request](https://github.com/docker-library/drupal/pull/176), changed the location of Drupal from /var/www/html to /opt/drupal (with a symlink from /var/www/html).

This causes various issues with downstream projects which depend on the dcycle/drupal:9php8 image; it has therefore been decided that for the dcycle/drupal, Drupal would remain in /var/www/html, rather than be in /opt/drupal.

Thus, in ./Dockerfile-9php8, [code was added to completely remove /opt/drupal and /var/www/html, and reinstall with our own composer.json files at ./docker-resources/*/composer.json](https://github.com/dcycle/docker-drupal/pull/13).

Docker tags
-----

### Recommended Docker tags

* **9php8.YYYY-MM-DD-HH-MM-SS-UTC**: A Drupal 9 with PHP 8 and Composer 2 image frozen in time.
* **9php8**: The latest Drupal 9 image with PHP 8 and Composer 2, rebuilt Wednesdays.
* **7.YYYY-MM-DD-HH-MM-SS-UTC**: A Drupal 7 image frozen in time.
* **7**: The latest Drupal 7 image, rebuilt Wednesdays.

Other tags, including PHP 8, and Drupal 9 on PHP 7, are deprecated.

Usage example
-----

See [Dcycle Drupal Starterkit](https://github.com/dcycle/starterkit-drupal8site).
