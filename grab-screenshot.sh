#!/bin/bash

set -e

screenshot_filename="$1"
if [[ -z "$screenshot_filename" ]]; then
  echo >&2 "Usage: $(basename "$0") <screenshot_filename>"
  exit 1
fi

docker build -t grab-screenshot .
docker run --rm -v "$PWD":/src grab-screenshot \
  bash -c "nginx & cd /src && grab-screenshot $screenshot_filename"
