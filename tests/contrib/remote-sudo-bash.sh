#!/bin/bash

tmp_file=$(mktemp)
read -r -d '' input
echo "$input" > "$tmp_file"
echo "$1" | sudo -S bash +x "$tmp_file"
