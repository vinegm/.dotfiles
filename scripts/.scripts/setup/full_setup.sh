#!/usr/bin/env bash

# This script installs packages and stows dotfiles based on a manifest file.
# It detects the OS and installs the necessary tools and packages accordingly.

set -e
MANIFEST="manifest.json"
source /etc/os-release

# List of supported OS
SUPPORTED_OS=("arch" "ubuntu")

if [[ ! " ${SUPPORTED_OS[@]} " =~ " ${ID} " ]]; then
  echo "Unsupported OS: $ID. Supported OS are: ${SUPPORTED_OS[*]}"
  exit 1
fi

if [[ "$ID" == "arch" && ! $(command -v yay) ]]; then
  echo "yay is not installed. Please install yay before continuing."
  exit 1
fi

OS=$ID
echo "Detected OS: '$OS'"

# Install basic tools
install_tools() {
  if ! command -v jq &> /dev/null; then
    echo "Installing jq..."
    if [ "$OS" = "arch" ]; then
      sudo pacman -S --noconfirm jq
    else
      sudo apt update
      sudo apt install -y jq
    fi
  fi

  if ! command -v stow &> /dev/null; then
    echo "Installing stow..."
    if [ "$OS" = "arch" ]; then
      sudo pacman -S --noconfirm stow
    else
      sudo apt install -y stow
    fi
  fi
}

# Install packages
install_packages() {
  packages=$(jq -c '.[]' "$MANIFEST")

  pacman_pkgs=()
  aur_pkgs=()
  apt_pkgs=()

  for pkg in $packages; do
    name=$(echo $pkg | jq -r '.name')
    source=$(echo $pkg | jq -r ".sources.${OS}")

    if [ "$source" != "null" ]; then
      case "$source" in
        pacman)
          pacman_pkgs+=("$name")
          ;;
        yay)
          aur_pkgs+=("$name")
          ;;
        apt)
          apt_pkgs+=("$name")
          ;;
      esac
    fi
  done

  if [ "$OS" = "arch" ]; then
    echo "Installing pacman packages: ${aur_pkgs[*]}"
    sudo pacman -S --needed --noconfirm "${pacman_pkgs[@]}"

    if [ ! ${#aur_pkgs[@]} -gt 0 ]; then
      return
    fi

    echo "Installing AUR packages: ${aur_pkgs[*]}"
    for pkg in "${aur_pkgs[@]}"; do
      yay -S --needed --noconfirm "$pkg"
    done
  fi

  if [ "$OS" = "ubuntu" ] && [ ${#apt_pkgs[@]} -gt 0 ]; then
    echo "Installing apt packages: ${apt_pkgs[*]}"
    sudo apt install -y "${apt_pkgs[@]}"
  fi
}

# Stow dotfiles if directory exists
stow_dotfiles() {
  echo "Checking for dotfiles to stow..."
  packages=$(jq -r '.[].name' "$MANIFEST")
  for name in $packages; do
    if [ -d "$name" ]; then
      echo "Stowing $name..."
      stow "$name"
    fi
  done
}

install_tools
stow_dotfiles
install_packages

echo "Setup complete!"

