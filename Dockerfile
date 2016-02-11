FROM resnullius/alpine:edge
MAINTAINER Jose-Luis Rivas <me@ghostbar.co>

VOLUME /opt/repo
VOLUME /opt/keys

RUN apk-install alpine-sdk && \
  mkdir -p /var/cache/distfiles
