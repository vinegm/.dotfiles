#!/bin/bash

set -e
DOTFILES="$HOME/.dotfiles"

if ! [ -d $DOTFILES ]; then
  echo "Getting the dotfiles..."
  git clone https://github.com/vinegm/.dotfiles.git $DOTFILES
fi

bash $DOTFILES/scripts/setup/stow_setup.sh
bash $DOTFILES/scripts/setup/install_setup.sh -y
bash $DOTFILES/scripts/cleanups/cleanup_handler.sh

