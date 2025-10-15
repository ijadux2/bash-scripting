#!/bin/bash

# Fetch all available packages with descriptions (one line per package)
packages=$(apt-cache search .)

# Use fzf to fuzzily search packages with preview showing detailed info
selected=$(echo "$packages" | fzf --multi --preview 'apt-cache show $(echo {} | cut -d" " -f1)' --preview-window=up:60% --ansi)

# Extract package names from selected lines
pkgs=$(echo "$selected" | cut -d" " -f1)

if [ -n "$pkgs" ]; then
  echo "Installing selected packages: $pkgs"
  # Install selected packages via sudo apt install
  echo $pkgs | xargs sudo apt install -y
else
  echo "No packages selected."
fi

