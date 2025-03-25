#!/bin/bash

# Handles stowing the directories
# in the dotfiles for easier setup.

DOTFILES_DIR="$(pwd)"
IGNORE_LIST=(".git" "stow_ignore/")

# Get all directories, excluding ignored ones
dirs=$(ls -d */)

for ignore in "${IGNORE_LIST[@]}"; do
    dirs=$(echo "$dirs" | grep -v "^$ignore$")
done

# default action
ACTION=${1:-stow}

stow_action() {
    local action=$1
    local dir=$2

    case "$action" in
        stow) stow -D "$dir" && stow "$dir" ;;
        unstow) stow -D "$dir" ;;
        *)
            echo "Action not recognized"
            exit 1
        ;;
    esac
}

for dir in $dirs; do
    stow_action "$ACTION" "$dir"
done

