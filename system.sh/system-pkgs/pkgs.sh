#!/usr/bin/bash

# this file automatically install pkgs for my system !
# List of packages to install
packages=(
  vim
  tmux
  vlc
  ranger
)

# Loop to check and install missing packages
for pkg in "${packages[@]}"; do
  if apt list --installed "$pkg" &>/dev/null; then
    echo "Package '$pkg' is already installed."
  else
    echo "Installing package '$pkg'..."
    sudo apt install -y "$pkg"
  fi
done
