#!/bin/bash

set -e
set -x

docker build -t kasmvnc-functional-test .
docker_group=2375
docker run --rm -v "$PWD":/src  -v /var/run/docker.sock:/var/run/docker.sock \
  -e KASMVNC_IMAGE_TO_TEST_ON \
  --group-add "$docker_group" kasmvnc-functional-test \
  bash -c 'nginx & id; groups; tail /etc/group; ls -l /var/run/docker.sock; cd /src && /tmp/test-and-render-report'
