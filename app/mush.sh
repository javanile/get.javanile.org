#!/usr/bin/env bash
set -e

bin=/usr/local/bin/mush
chmod=chmod
curl=curl

if [ "$EUID" -ne 0 ]; then
    echo "To install '${bin}' file you need root privileges"
    curl="sudo ${curl}"
    chmod="sudo ${chmod}"
fi

${curl} -sL https://raw.githubusercontent.com/javanile/mush/main/bin/mush -o ${bin}
${chmod} +x ${bin}

echo -n "Installed "
mush --version
