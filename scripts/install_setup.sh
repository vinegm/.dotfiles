#!/bin/bash

set -e

pacman_packages=(
  arandr
  bat
  btop
  dunst
  fzf
  git
  git-delta
  i3-wm
  kitty
  lazygit
  ly
  neovim
  pavucontrol
  picom
  playerctl
  polybar
  rofi
  thunar
  tmux
  zoxide
  zsh
)

yay_packages=(
  i3lock-color
  tokyonight-gtk-theme-git
  ttf-jetbrains-mono-nerd
  xautolock
)

echo "Installing required pacman packages..."
sudo pacman -Sy --noconfirm --needed "${pacman_packages[@]}"
bat cache --build # Build the bat cache for the theme

if ! [ -d "$HOME/.oh-my-zsh/" ]; then
  # Change the default shell to zsh if it is not already set
  if [ "$SHELL" != "$(which zsh)" ]; then
    chsh -s "$(which zsh)"
  fi

  echo "Installing oh my zsh..."
  CHSH=no RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  # The zshrc.pre- should already have been stowed
  rm -f "$HOME"/.zshrc
  mv "$HOME"/.zshrc.pre-oh-my-zsh "$HOME"/.zshrc
fi

if [ ! "$(command -v yay)" ]; then
  echo "Installing Yay..."

  git clone https://aur.archlinux.org/yay.git "$HOME"/yay
  cd "$HOME"/yay

  makepkg -si
fi

echo "Installing required yay packages..."
yay -Sy --noconfirm --needed "${yay_packages[*]}"
