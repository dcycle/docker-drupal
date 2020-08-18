IMAGE="$1"

echo "*************"
echo "** SMOKE TEST ON IMAGE $1"
echo "*************"

echo ' => working directory'
docker run --rm "$IMAGE" /bin/bash -c 'pwd'
echo ' => listing contents'
docker run --rm "$IMAGE" /bin/bash -c 'ls -lah'
echo ' => make sure .htaccess exists'
docker run --rm "$IMAGE" /bin/bash -c "ls -lah | grep .htaccess"
