FROM resnullius/alpine:3.3
MAINTAINER Jose-Luis Rivas <me@ghostbar.co>

VOLUME /opt/repo
VOLUME /opt/conf

COPY scripts/ /opt/scripts

RUN apk-install alpine-sdk && \
  mkdir -p /var/cache/distfiles
