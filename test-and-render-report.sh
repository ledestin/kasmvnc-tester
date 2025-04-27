#!/bin/bash

set -e

docker build -t kasmvnc-functional-test .
docker_group=$(grep docker /etc/group | awk -F: '{ print $3 }')
docker run --rm -v "$PWD":/src  -v /var/run/docker.sock:/var/run/docker.sock \
  -e KASMVNC_IMAGE_TO_TEST_ON \
  --group-add "$docker_group" kasmvnc-functional-test \
  bash -c 'nginx & cd /src && /tmp/test-and-render-report'
