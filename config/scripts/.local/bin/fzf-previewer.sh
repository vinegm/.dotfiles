#!/usr/bin/env bash

file="$1"

if [[ -d "$file" ]]; then
    ls -oAh --color=always -- "$file"
elif [[ -f "$file" ]]; then
    bat --style=numbers --color=always -- "$file"
else
    exit 1
fi
