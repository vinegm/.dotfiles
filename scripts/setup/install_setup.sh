#!/bin/bash

set -e
skip_prompt=false

while getopts "y" opt; do
  case $opt in
    y)
      skip_prompt=true
      ;;
    *)
      ;;
  esac
done

pacman_packages=(
  sddm
  i3-wm
  picom
  polybar
  rofi
  kitty
  tmux
  zsh
  btop
  neovim
  git
  lazygit
  git-delta
  bat
  dunst
  playerctl
  pavucontrol
  arandr
  thunar
)

yay_packages=(
  # sddm-theme-tokyo-night-git
  ttf-jetbrains-mono-nerd
  xcursor-simp1e-tokyo-night
  tokyonight-gtk-theme-git
  i3lock-color
)

extras=(
  spotify
  discord
  brave-bin
  obsidian
  visual-studio-code-bin
)

echo "Installing required pacman packages..."
sudo pacman -S --needed ${pacman_packages[*]}

if ! [ -d "$HOME/.oh-my-zsh/" ]; then
  echo "Installing oh my zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  # The zshrc.pre- should already have been stowed
  rm -f "$HOME/.zshrc"
  mv "$HOME/.zshrc.pre-oh-my-zsh" "$HOME/.zshrc"
fi

if [ ! $(command -v yay) ]; then
  echo "Installing Yay..."
  git clone https://aur.archlinux.org/yay.git $HOME/yay
  cd $HOME/yay
  makepkg -si
fi

echo "Installing required yay packages..."
yay -S --needed ${yay_packages[*]}

if ! $skip_prompt; then
  read -p "Do you want the extra packages? eg. discord, spotify... (y/n): " answer
  if [[ "${answer,,}" != "y" ]]; then
    exit 0
  fi
fi

yay -S --needed ${extras[*]}

