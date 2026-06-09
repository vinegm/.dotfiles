#!/usr/bin/env bash

file="$1"

lsCmd=("ls" "-oAh" "--color=always")
catCmd=("cat")

if command -v eza >/dev/null 2>&1; then
    lsCmd=("eza" "-lah" "--color=always")
fi

if command -v bat >/dev/null 2>&1; then
    catCmd=("bat" "--style=numbers" "--color=always")
elif command -v batcat >/dev/null 2>&1; then
    catCmd=("batcat" "--style=numbers" "--color=always")
fi

if [[ -d "$file" ]]; then
    "${lsCmd[@]}" -- "$file"
elif [[ -f "$file" ]]; then
    "${catCmd[@]}" -- "$file"
else
    exit 1
fi
