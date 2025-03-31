FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y python3-selenium chromium chromium-driver
RUN apt-get install -y python3-requests python3

COPY grab_screenshot /tmp/
COPY barebones-login /tmp/
COPY chromium-wrapped /usr/bin/

RUN useradd -m docker
USER docker
WORKDIR /home/docker
