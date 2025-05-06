#!/bin/bash

set -e
set -x

sed "s/workspaces_container_ip/$workspaces_container_ip/" \
  kasmvnc.nginx.template > .build/kasmvnc.nginx
docker build -t kasmvnc-functional-test .
if [ -n "$CI" ]; then
  docker_group=2375
else
  docker_group=$(stat -c '%g' /var/run/docker.sock)
fi
docker run --rm -v "$PWD":/src  -v /var/run/docker.sock:/var/run/docker.sock \
  -e KASMVNC_IMAGE_TO_TEST_ON \
  --group-add "$docker_group" kasmvnc-functional-test \
  bash -c 'nginx & cd /src && /tmp/test-and-render-report'
