# docker-alpine-dev

Initial image for doing alpine development.

It has `alpine-sdk`, expects two volumes: `/opt/repo` (where the packages live)
and `/etc/apk/keys` where the developer's keys should go.
