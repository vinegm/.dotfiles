#!/bin/bash

# Ubuntu Minimal Cleanup Script

echo "Cleaning apt cache and removing unused packages..."
sudo apt clean
sudo apt-get autoclean
sudo apt autoremove -y

