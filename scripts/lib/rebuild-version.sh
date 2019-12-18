VERSION="$1"
BASEIMAGEVERSION="$2"

echo "*************"
echo "** REBUILDING VERSION $1"
echo "** USING BASE IMAGE $2"
echo "*************"

# Start by getting the latest version of the official drupal image
docker pull drupal:"$BASEIMAGEVERSION"
# Rebuild the entire thing
docker build -f="Dockerfile-$VERSION" --no-cache -t dcycle/drupal:"$VERSION" .
docker build -f="Dockerfile-$VERSION" -t dcycle/drupal:"$VERSION".$DATE .
docker login -u"$DOCKERHUBUSER" -p"$DOCKERHUBPASS"
docker push dcycle/drupal:"$VERSION"
docker push dcycle/drupal:"$VERSION"."$DATE"
docker rmi dcycle/drupal:"$VERSION"
docker rmi dcycle/drupal:"$VERSION"."$DATE"
