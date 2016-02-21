docker-alpine-dev
=================

WHAT IS THIS?
-------------

Initial image for doing alpine development. Running this image you should be
able to build packages for Alpine's different versions inside a docker container
and ship them for installation.

There are two main scripts, one for generating your signing-key which should be
used just once and other for building which expects you to have a signing-key
and an `abuild.conf` which your data.

The build script allows you to use your own packages as a local repo for
building with them as dependency requirements and leaves you with a directory
which you could just publish on the internet and point other people to use as a
repository, directly.

VOLUMES
-------

* `/opt/conf`
* `/opt/keys`
* `/opt/src`
* `/opt/repo`

AUTHOR AND LICENSE
------------------
© 2016, Jose-Luis Rivas `<me@ghostbar.co>`.

This software is licensed under the MIT terms, you can find a copy of the
license on the `LICENSE` file in this repository.
