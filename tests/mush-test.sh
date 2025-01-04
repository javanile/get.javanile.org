#!/bin/bash
set -e

rm -fr $HOME/.mush

bash app/mush.sh --branch develop
