FROM kasmweb/ubuntu-jammy-desktop:develop

ENV DEBIAN_FRONTEND=noninteractive

USER root
COPY output/jammy/*.deb /tmp/
RUN dpkg -i --force-confdef --force-confold /tmp/*.deb
USER 1000
