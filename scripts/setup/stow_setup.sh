#!/bin/bash

# Handles stowing the directories
# in the dotfiles for easier setup.

DOTFILES="$HOME/.dotfiles"

dirs=$(ls -d $DOTFILES/config/*/)

# default action
ACTION=${1:-stow}

stow_action() {
    local action=$1
    local dir=$2

    case "$action" in
        stow) stow -d "$DOTFILES/config/" -t "$HOME" -R "$dir" ;;
        unstow) stow -d "$DOTFILES/config/" -t "$HOME" -D "$dir" ;;
        *)
            echo "Action not recognized"
            exit 1
        ;;
    esac
}

for dir in $dirs; do
    dir_name=$(basename "$dir")
    stow_action "$ACTION" "$dir_name"
done

