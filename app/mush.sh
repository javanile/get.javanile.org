#!/usr/bin/env bash
set -e

## Install latest stable version
curl -s https://get.javanile.org/install | bash -s mush 0.2.0

## Override with development branch
if [ "$1" = "--branch" ] && [ -n "$2" ]; then
  git_uri=https://github.com/javanile/mush.git
  src_dir=$HOME/.mush/registry/src/https-github-com-javanile-mush/mush

  mush install console
  mkdir -p "${src_dir}"
  git clone --single-branch --branch "$2" "${git_uri}" "${src_dir}/$2"
  cd "${src_dir}/$2"
  mush build --release
  cp bin/mush ${HOME}/.mush/bin/mush
  ${HOME}/.mush/bin/mush --version
fi

