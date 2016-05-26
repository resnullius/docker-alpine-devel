#!/usr/bin/env bash
# vim: ft=sh tw=80

declare help="
Entrypoint for docker-alpine-devel images.

Usage:
  entrypoint.sh build
  entrypoint.sh checksum
  entrypoint.sh --version
  entrypoint.sh -h | --help

Options:
  -h --help       Show this screen.
  --version       Show version.
"

declare version="
Version: 2.0.0.
Licensed under the MIT terms.
"

declare USER
USER=$(whoami)
declare ARCH
ARCH=$(uname -m)
declare BUILD_ARCH="$ARCH"

declare PRE
PRE=$(echo "$ARCH" | grep "arm")
if [ "$PRE" = "$ARCH" ]; then
  BUILD_ARCH="armhf"
fi

declare REPO_DIR=/opt/repo/"$BUILD_ARCH"

setup_system() {
  bash /bin/setup-system.sh
}

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

add_local_repo() {
  [ -d "$REPO_DIR" ] && \
    [ -f "$REPO_DIR"/APKINDEX.tar.gz ] && \
    sudo sh -c "echo /opt/repo >> /etc/apk/repositories"
  echo "If there was anything on your repo, it's available now"
}

add_extra_repo() {
  sudo sh -c "echo $1 >> /etc/apk/repositories"
  echo "Added extra repo $1."
}

run_build() {
  mkdir -p "$HOME"/packages
  abuild-apk update
  abuild checksum && abuild -r
}

run_only_checksum() {
  abuild checksum
}

copy_finalpkg() {
  [ -d "$REPO_DIR" ] || sudo mkdir -p "$REPO_DIR"
  sudo cp "$HOME"/packages/builder/"$BUILD_ARCH"/*.apk /opt/repo/"$BUILD_ARCH"/
}

gen_apkindex() {
  cd /opt/repo/"$BUILD_ARCH"/
  sudo apk index -o APKINDEX.tar.gz ./*.apk
  sudo abuild-sign APKINDEX.tar.gz
}

update_apkbuild() {
  sudo cp "$HOME"/src/APKBUILD /opt/src/
}

build_apk() {
  copy_keys
  copy_src
  add_local_repo
  run_build "$@"
  copy_finalpkg
  gen_apkindex
  update_apkbuild
}

do_checksum() {
  copy_src
  run_only_checksum
  update_apkbuild
}

print_version() {
  echo "$version"
}

print_help() {
  echo "$help"
}

main() {
  set -eo pipefail; [[ "$TRACE" ]] && set -x

  setup_system

  declare cmd="$1"
  case "$cmd" in
    build)          shift; build_apk "$@";;
    checksum)       shift; do_checksum "$@";;
    *)              print_help "$@";;
  esac
}

main "$@"
