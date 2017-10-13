VERSION="$1"

# Start by getting the latest version of the official drupal image
docker pull drupal:"$VERSION"
# Rebuild the entire thing
docker build -f="Dockerfile-$VERSION" --no-cache -t dcycle/drupal:"$VERSION" .
docker build -f="Dockerfile-$VERSION" -t dcycle/drupal:"$VERSION".$DATE .
docker login -u"$DOCKERHUBUSER" -p"$DOCKERHUBPASS"
docker push dcycle/drupal:"$VERSION"
docker push dcycle/drupal:"$VERSION"."$DATE"
