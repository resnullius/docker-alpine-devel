FROM gliderlabs/alpine:edge
MAINTAINER Jose-Luis Rivas <me@ghostbar.co>

VOLUME /opt/repo
VOLUME /etc/apk/keys

RUN apk-install alpine-sdk && \
  mkdir -p /var/cache/distfiles /opt/repo && \
  sed -i 's/REPODEST=\$HOME\/packages\//REPODEST=\/opt\/repo\//' /etc/abuild.conf
