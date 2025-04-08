#!/bin/bash

set -e

docker build -t kasmvnc-functional-test .
docker_group=$(grep docker /etc/group | awk -F: '{ print $3 }')
docker run --rm -v "$PWD":/src  -v /var/run/docker.sock:/var/run/docker.sock \
  --group-add "$docker_group" kasmvnc-functional-test \
  bash -c 'nginx & cd /src && xvfb-run --auto-servernum --server-num=1 /tmp/test-and-render-report'
