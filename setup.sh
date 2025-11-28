#!/bin/bash

# This script sets up the environment by installing necessary dependencies,
# cloning the dotfiles repository if it doesn't exist, and running setup scripts.

set -e

DOTFILES="$HOME/.dotfiles"

dependencies=(
  "bash"
  "curl"
  "git"
  "stow"
)

for dependency in "${dependencies[@]}"; do
  if command -v "$dependency" &>/dev/null; then
    continue
  fi

  read -r -p "$dependency is not installed. It is needed for the setup, do you allow instalation? (y/n)" answer

  if [[ "${answer,,}" == "n" ]]; then
    echo "Exiting setup."
    exit 0
  fi

  if [[ "${answer,,}" == "y" ]]; then
    echo "Installing $dependency."
    sudo pacman -Sy --noconfirm --needed "$dependency"
    continue
  fi

  echo "Invalid input. Exiting setup."
  exit 1
done

if ! [ -d "$DOTFILES" ]; then
  echo "Getting the dotfiles..."
  git clone https://github.com/vinegm/.dotfiles.git "$DOTFILES"
fi

bash "$DOTFILES"/scripts/stow_setup.sh
bash "$DOTFILES"/scripts/install_setup.sh
bash "$DOTFILES"/scripts/cleanup.sh
