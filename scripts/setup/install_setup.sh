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
  ly
  i3-wm
  picom
  polybar
  rofi
  kitty
  tmux
  zsh
  zoxide
  fzf
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
  ttf-jetbrains-mono-nerd
  tokyonight-gtk-theme-git
  i3lock-color
  xautolock
)

extras=(
  spotify
  discord
  brave-bin
  obsidian
  visual-studio-code-bin
)

echo "Installing required pacman packages..."
sudo pacman -Sy --noconfirm --needed ${pacman_packages[*]}

if ! [ -d "$HOME/.oh-my-zsh/" ]; then
  # Change the default shell to zsh if it is not already set
  if [ "$SHELL" != "$(which zsh)" ]; then
    chsh -s "$(which zsh)"
  fi

  echo "Installing oh my zsh..."
  CHSH=no RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

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
yay -Sy --noconfirm --needed ${yay_packages[*]}

if ! $skip_prompt; then
  read -p "Do you want the extra packages? eg. discord, spotify... (y/n): " answer
  if [[ "${answer,,}" != "y" ]]; then
    exit 0
  fi
fi

yay -Sy --needed ${extras[*]}

