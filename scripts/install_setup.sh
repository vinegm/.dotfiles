#!/bin/bash

# Installs required packages for the system setup.
# Usage:
#   ./install_setup.sh [-w] [-x] [-y]
# Options:
#   -w  Install Wayland packages
#   -x  Install X11 packages (needs yay for some packages)
#   -y  Install yay AUR packages

set -e

install_wayland=false
install_x11=false
install_yay_pkgs=false

while getopts "wxy" flag; do
  case "$flag" in
  w) install_wayland=true ;;
  x) install_x11=true ;;
  y) install_yay_pkgs=true ;;
  *)
    echo "Unknown option: $flag"
    echo "Usage: $0 [-w] [-x] [-y]"
    exit 1
    ;;
  esac
done

general_packages=(
  bat         # improved cat with syntax highlighting
  btop        # TUI resource monitor
  dunst       # notification daemon
  fzf         # command-line fuzzy finder
  git         # version control
  git-delta   # improved git diff viewer
  kitty       # terminal emulator
  lazygit     # TUI for git
  ly          # TUI display manager
  neovim      # text editor
  pavucontrol # volume control
  playerctl   # media player controller
  rofi        # application launcher
  thunar      # file manager
  tmux        # terminal multiplexer
  zoxide      # smarter cd command
  zsh         # shell
)

yay_packages=(
  tokyonight-gtk-theme-git # tokyonight gtk theme
  ttf-jetbrains-mono-nerd  # nerd font
)

wayland_packages=(
  grim      # screenshot utility
  hpyridle  # auto screen lock
  hyprland  # compositor/window manager
  hyprlock  # screen locker
  hyprpaper # wallpaper setter
  slurp     # region selection utility
  waybar    # status bar
)

x11_packages=(
  arandr    # display manager
  flameshot # screenshot utility
  i3-wm     # window manager
  picom     # compositor
  polybar   # status bar
)

x11_yay_packages=(
  i3lock-color # screen locker with color support
  xautolock    # auto screen lock
)

echo "Installing required pacman packages..."
sudo pacman -Sy --noconfirm --needed "${general_packages[@]}"
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

if $install_yay_pkgs; then
  if [ ! "$(command -v yay)" ]; then
    echo "Installing Yay..."

    git clone https://aur.archlinux.org/yay.git "$HOME"/yay
    cd "$HOME"/yay

    makepkg -si
  fi

  echo "Installing required yay packages..."
  yay -Sy --noconfirm --needed "${yay_packages[*]}"
fi

if $install_wayland; then
  echo "Installing Wayland packages..."
  yay -Sy --noconfirm --needed "${wayland_packages[@]}"
fi

if $install_x11; then
  echo "Installing X11 packages..."
  sudo pacman -Sy --noconfirm --needed "${x11_packages[@]}"

  if ! $install_yay_pkgs; then
    echo "Installing X11 yay packages..."
    yay -Sy --noconfirm --needed "${x11_yay_packages[@]}"
  fi
fi
