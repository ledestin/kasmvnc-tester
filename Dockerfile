FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y python3-selenium chromium chromium-driver
RUN apt-get update && apt-get install -y python3-jinja2 python3-docker
RUN apt-get update && apt-get install -y nginx ssl-cert curl
RUN apt-get update && apt-get install -y xsel xvfb
RUN apt-get update && apt-get install -y python3-xvfbwrapper

COPY kasmvnc.nginx /etc/nginx/sites-available/kasmvnc
RUN ln -s /etc/nginx/sites-available/kasmvnc /etc/nginx/sites-enabled/

RUN addgroup --system nginx
RUN adduser --ingroup nginx --disabled-password nginx

RUN mkdir -p /var/run/nginx && \
    chown -R nginx:nginx /var/run/nginx && \
    chown -R nginx:nginx /run && \
    mkdir -p /var/cache/nginx && \
    chown -R nginx:nginx /var/cache/nginx && \
    mkdir -p /var/lib/nginx && \
    chown -R nginx:nginx /var/lib/nginx && \
    mkdir -p /var/log/nginx && \
    chown -R nginx:nginx /var/log/nginx && \
    chown -R nginx:nginx /etc/nginx/conf.d && \
    chown -R nginx:nginx /usr/share/nginx/html

COPY test-and-render-report /tmp/
COPY selenium_utils.py /tmp/
COPY chromium-wrapped /usr/bin/

RUN adduser nginx ssl-cert
USER nginx:ssl-cert
WORKDIR /home/nginx
