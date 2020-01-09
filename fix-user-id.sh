#!/bin/bash

NEW_UID="$(stat -c%u $(pwd))"
NEW_GID="$(stat -c%g $(pwd))"

chown maven:maven /home/maven

if [ "$(id -u maven)" != "$NEW_UID" ]; then
  usermod -o -u "$NEW_UID" maven
fi
if [ "$(id -g maven)" != "$NEW_GID" ]; then
  groupmod -o -g "$NEW_GID" maven
fi

if [ -e /var/run/docker.sock ]; then
  groupmod -o -g $(stat -c%g /var/run/docker.sock) docker
fi

runuser -u maven -- $@
