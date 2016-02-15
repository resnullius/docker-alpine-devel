#!/usr/bin/env bash

declare help="
Update script for Dockerfile.base into versions.

Usage:
  update-dockerfiles.bash run
  update-dockerfiles.bash --version
  update-dockerfiles.bash -h | --help

Options:
  -h --help                 Show this screen.
  --version                 Show versions.
"

declare version="
Version: 1.0.0.
Licensed under the MIT terms.
"

declare FILES_BASE="${FILES_BASE:-Dockerfile.base}"
declare FILES_CHILDS="${FILES_CHILDS:-edge 3.3}"
declare FILES_CHILDS_DIR="${FILES_CHILDS_DIR:-versions}"

copy_files() {
  for file in $FILES_CHILDS; do
    echo "Copying and renaming for $file"
    mkdir -p "$FILES_CHILDS_DIR"/"$file"
    cp "$FILES_BASE" "$FILES_CHILDS_DIR"/"$file"/Dockerfile
  done
}

change_version() {
  for file in $FILES_CHILDS; do
    echo "Changing tag for $file"
    sed -i '' -e "s/alpine:/alpine:$file/" "$FILES_CHILDS_DIR/$file/Dockerfile"
  done
}

run_updater() {
  copy_files
  change_version
}

version() {
  echo "$version"
}

help() {
  echo "$help"
}

main() {
  set -eo pipefail; [[ "$TRACE" ]] && set -x
  declare cmd="$1"
  case "$cmd" in
    run)              shift; run_updater "$@";;
    -h|--help)        shift; help "$@";;
    --version)        shift; version;;
    *)                help "$@";;
  esac
}

main "$@"
