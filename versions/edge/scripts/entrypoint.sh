#!/usr/bin/env sh
set -e
USER=$(whoami)
ARCH=$(uname -m)

copy_keys() {
  mkdir "$HOME"/.abuild
  sudo cp /opt/keys/*.rsa* "$HOME"/.abuild/ && \
    sudo chown "$USER" "$HOME"/.abuild/*
  sudo cp /opt/keys/*.rsa.pub /etc/apk/keys
}

copy_src() {
  sudo cp -R /opt/src/* "$HOME"/src && \
    sudo chown -R "$USER" "$HOME"/src
}

run_build() {
  mkdir -p "$HOME"/packages
  abuild-apk update
  abuild checksum && abuild "$@"
}

copy_finalpkg() {
  sudo mkdir -p /opt/repo/"$ARCH"/
  sudo cp "$HOME"/packages/builder/"$ARCH"/*.apk /opt/repo/"$ARCH"/
}

gen_apkindex() {
  cd /opt/repo/"$ARCH"/
  sudo apk index -o APKINDEX.tar.gz ./*.apk
}

main() {
  sh /bin/setup-system.sh

  copy_keys
  copy_src
  run_build "$@"
  copy_finalpkg
  gen_apkindex
}

main "$@"
