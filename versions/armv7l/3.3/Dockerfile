FROM resnullius/alpine-armv7l:3.3
MAINTAINER Jose-Luis Rivas <me@ghostbar.co>

VOLUME /opt/repo
VOLUME /opt/keys
VOLUME /opt/conf
VOLUME /opt/src

WORKDIR /home/builder/src

RUN apk-install alpine-sdk coreutils bash && \
  rm /etc/abuild.conf && \
  mkdir -p /var/cache/distfiles && \
  chmod a+w /var/cache/distfiles && \
  adduser -G abuild -S builder && \
  echo "builder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER builder
COPY scripts/* /bin/

ENTRYPOINT ["entrypoint.sh"]
