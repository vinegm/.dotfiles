#!/bin/bash

# This script sets up the environment by installing necessary dependencies,
# cloning the dotfiles repository if it doesn't exist, and running setup scripts.
# Usage:
#   ./setup.sh [-w] [-x] [-y]
# Options:
#   -w  Install Wayland packages
#   -x  Install X11 packages (needs yay for some packages)
#   -y  Install yay AUR packages

set -e

child_flags=""

while getopts "nwxy" flag; do
  case "$flag" in
  w) child_flags+="w" ;;
  x) child_flags+="x" ;;
  y) child_flags+="y" ;;
  *)
    echo "Unknown option: $flag"
    echo "Usage: $0 [-w] [-x] [-y]"
    exit 1
    ;;
  esac
done

DOTFILES="$HOME/.dotfiles"

dependencies=(
  bash
  curl
  git
  stow
)

for dependency in "${dependencies[@]}"; do
  if command -v "$dependency" &>/dev/null; then
    continue
  fi

  read -r -p "$dependency is not installed. It is needed for the setup, do you allow instalation? (Y/n) " answer
  answer="${answer,,}"

  case "$answer" in
  y | "") sudo pacman -Sy --noconfirm --needed "$dependency" ;;
  n)
    echo "Exiting setup."
    exit 0
    ;;
  *)
    echo "Invalid input. Exiting setup."
    exit 1
    ;;
  esac
done

clone_repo() {
  git clone https://github.com/vinegm/.dotfiles.git "$DOTFILES"
}

if [ -d "$DOTFILES" ]; then
  echo "A \"~/.dotfiles\" directory already exists, the setup needs to use this directory."
  echo "Do you want to continue without cloning the repository? (Will use existing directory)"

  read -r -p "[Y]es / [n]o / [o]verwrite directory : " answer
  answer="${answer,,}"

  case "$answer" in
  y | "") ;;
  n)
    echo "Exiting setup."
    exit 0
    ;;
  o)
    rm -rf "$DOTFILES"
    clone_repo
    ;;
  *)
    echo "Invalid input. Exiting setup."
    exit 1
    ;;
  esac
else
  echo "Cloning dotfiles repository..."
  clone_repo
fi

if [ -n "$child_flags" ]; then
  child_flags="-$child_flags"
fi

bash "$DOTFILES"/scripts/install_setup.sh "$child_flags"
bash "$DOTFILES"/scripts/stow_setup.sh
bash "$DOTFILES"/scripts/cleanup.sh
