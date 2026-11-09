#!/bin/bash

# Handles stowing the directories
# in the dotfiles for easier setup.
# Usage:
#   ./stow_setup.sh [action]
# Actions:
#   stow   - Stows all directories (default)
#   unstow - Unstows all directories

set -e

DOTFILES="$HOME/.dotfiles"
dirs=$(ls -d "$DOTFILES"/config/*/)

# default action
ACTION=${1:-stow}

# Packages allowed to be linked
# as a whole directory.
FOLD_PACKAGES=(
    nvim
)

stow_action() {
    local action=$1
    local dir=$2
    local fold_opt="--no-folding"

    local pkg
    for pkg in "${FOLD_PACKAGES[@]}"; do
        [[ "$pkg" == "$dir" ]] && fold_opt=""
    done

    case "$action" in
    stow) stow -d "$DOTFILES"/config/ -t "$HOME" $fold_opt -R "$dir" ;;
    unstow) stow -d "$DOTFILES"/config/ -t "$HOME" -D "$dir" ;;
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
