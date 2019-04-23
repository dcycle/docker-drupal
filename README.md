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

Docker tags
-----

* **8.YYYY-MM-DD-HH-MM-SS-UTC**: A Drupal 8 image frozen in time.
* **8**: The latest Drupal 8 image with Drush 8; this is no longer updated automatically after February 13, 2018. Please move to tag **8-drush9**.
* **8-drush9**: The latest Drupal 8 image with Drush 9; we use a different tag for Drush 9 and Drush 8 because Drush 9 no longer allows "drush dl", which was widely used on many Drupal 8-based images.
* **7.YYYY-MM-DD-HH-MM-SS-UTC**: A Drupal 7 image frozen in time.
* **7**: The latest Drupal 7 image.
