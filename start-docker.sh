#!/usr/bin/env bash
# Dockerfile from https://github.com/linuxserver/docker-dokuwiki
# source env.sh

sudo docker run -d \
  --name=mywiki \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=UTC \
  -p 80:80 \
  -p 443:443 `#optional` \
  -v ~/wiki/config:/config \
  --restart unless-stopped \
  ghcr.io/linuxserver/dokuwiki
