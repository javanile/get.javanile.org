#!/usr/bin/env bash
set -e

version=0.1.1
bin=/usr/local/bin/mush
chmod=chmod
curl=curl

if [ ! "$EUID" = "0" ]; then
    echo "To install '${bin}' file you need root privileges"
    curl="sudo ${curl}"
    chmod="sudo ${chmod}"
fi

${curl} -sL https://github.com/javanile/mush/releases/download/${version}/mush -o ${bin}
${chmod} +x ${bin}

echo "Installed "
mush --version
