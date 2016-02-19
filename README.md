docker-alpine-dev
=================

Initial image for doing alpine development.

It has `alpine-sdk`, expects two volumes: `/opt/repo` (where the packages live)
and `/etc/apk/keys` where the developer's keys should go.

VOLUMES
-------
Expects two volumes: `/opt/repo` and `/opt/conf`.

AUTHOR AND LICENSE
------------------
© 2016, Jose-Luis Rivas `<me@ghostbar.co>`.

This software is licensed under the MIT terms, you can find a copy of the
license on the `LICENSE` file in this repository.
