#!/bin/bash

set -e
DOTFILES="$HOME/.dotfiles"

dependencies=(
  "git"
  "stow"
  "curl"
)

for dependency in ${dependencies[@]}; do
  if ! command -v "$dependency" &>/dev/null; then
    read -p "$dependency is not installed. It is needed for the setup, do you allow instalation? (y/n)" answer

    if [[ "${answer,,}" == "n" ]]; then
      echo "Exiting setup."
      exit 0
    fi

    if [[ "${answer,,}" == "y" ]]; then
      echo "Installing $dependency."
      sudo pacman -Sy --noconfirm --needed "$dependency"
    else
     echo "Invalid input. Exiting setup."
      exit 1
    fi
  fi
done

if ! [ -d $DOTFILES ]; then
  echo "Getting the dotfiles..."
  git clone https://github.com/vinegm/.dotfiles.git $DOTFILES
fi

bash $DOTFILES/scripts/setup/stow_setup.sh
bash $DOTFILES/scripts/setup/install_setup.sh -y
bash $DOTFILES/scripts/cleanups/cleanup_handler.sh

