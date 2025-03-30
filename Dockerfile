FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y python3-selenium chromium

COPY grab_screenshot /tmp/
COPY chromium-wrapped /usr/bin/

CMD /tmp/grab_screenshot
