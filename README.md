A Drupal+Drush Docker image
-----

This image was created for two reasons:

 * [The "official" Drupal Docker image](https://hub.docker.com/_/drupal/) does not have Drush.
 * It takes a few days for it be updated after major security releases.

How security updates are managed
-----

We have a Jenkins server which attempts to rebuild the image without cache daily to pick up security updates. Users of this image are also encouraged to rebuild daily.
