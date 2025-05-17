#!/usr/bin/env bash
set -e

## Install latest stable version
curl -s https://get.javanile.org/install | bash -s mush 0.2.0

## Override with development branch
if [ "$1" = "--branch" ] && [ -n "$2" ]; then
  git_uri=https://github.com/javanile/mush.git
  src_dir=${HOME:-/root}/.mush/registry/src/https-github-com-javanile-mush/mush

  echo "Override with development branch: $2"
  mush install console
  mkdir -p "${src_dir}"
  rm -fr "${src_dir}/$2" && true
  git clone --single-branch --branch "$2" "${git_uri}" "${src_dir}/$2"
  cd "${src_dir}/$2"
  mush build --release
  cp bin/mush ${HOME:-/root}/.mush/bin/mush
  rm -fr "${HOME:-/root}/.mush/registry"
  ${HOME:-/root}/.mush/bin/mush build --release
  cp bin/mush ${HOME:-/root}/.mush/bin/mush
  ${HOME:-/root}/.mush/bin/mush --version
fi

