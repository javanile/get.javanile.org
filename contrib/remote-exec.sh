#!/bin/bash

tmp_file=$(mktemp)
read -r -d '' input
echo "$input" > "$tmp_file"
bash "$tmp_file"
