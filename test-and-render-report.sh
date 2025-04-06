#!/bin/bash

set -e

docker build -t kasmvnc-functional-test .
docker run --rm -v "$PWD":/src  -v /var/run/docker.sock:/var/run/docker.sock --group-add 997 kasmvnc-functional-test \
  bash -c 'nginx & cd /src && test-and-render-report'
