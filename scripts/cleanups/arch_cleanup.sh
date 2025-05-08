#!/bin/bash

# Arch Linux System Cleanup Script

orphans=$(pacman -Qdtq)
if [[ -n "$orphans" ]]; then
  echo "Removing orphaned packages..."
  sudo pacman -Rns --noconfirm $orphans
fi

if [ ! $(command -v yay) ]; then
  echo "Clearing yay cache..." 
  yay -Sc --noconfirm
  echo "Clearing yay orphan packages..." 
  yay -Yc --noconfirm
fi

