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

echo "Detected OS: '$ID'"

# Install basic tools
install_tools() {
  if ! command -v jq &> /dev/null; then
    echo "Installing jq..."
    if [ "$ID" = "arch" ]; then
      sudo pacman -S --noconfirm jq
    else
      sudo apt update
      sudo apt install -y jq
    fi
  fi

  if ! command -v stow &> /dev/null; then
    echo "Installing stow..."
    if [ "$ID" = "arch" ]; then
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
    source=$(echo $pkg | jq -r ".sources.${ID}")

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

  if [ "$ID" = "arch" ]; then
    if [ ! $(command -v yay) ]; then
      echo "Installing only pacman packages (no yay):"
      sudo pacman -S --noconfirm "${pacman_pkgs[@]}"
      return
    fi

    aur_pkgs+=("${pacman_pkgs[@]}")
    echo "Installing packages: ${aur_pkgs[*]}"
    yay -S --needed --noconfirm "${aur_pkgs[@]}"
  fi

  if [ "$ID" = "ubuntu" ]; then
    echo "Installing packages: ${apt_pkgs[*]}"
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

