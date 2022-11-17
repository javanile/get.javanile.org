#!/usr/bin/env bash
set -e

curl=curl
chmod=chmod

if [ $EUID -ne 0 ]; then
    curl="sudo ${curl}"
    chmod="sudo ${chmod}"
fi

${curl} -sL https://raw.githubusercontent.com/javanile/mush/main/bin/mush -o /usr/local/bin/mush
${chmod} +x /usr/local/bin/mush

echo -n "Installed "
mush --version
