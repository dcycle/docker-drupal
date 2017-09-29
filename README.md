A Drupal+Drush Docker image
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
