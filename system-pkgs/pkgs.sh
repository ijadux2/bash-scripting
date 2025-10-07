#!/usr/bin/bash

# this file automatically install pkgs for my system !
# List of packages to install
packages=(
  vim

  # add more packages here
)

# Loop to check and install missing packages
for pkg in "${packages[@]}"; do
  if nala list --installed "$pkg" &>/dev/null; then
    echo "Package '$pkg' is already installed."
  else
    echo "Installing package '$pkg'..."
    sudo nala install -y "$pkg"
  fi
done
