#!/usr/bin/bash

echo ">>> making a dev config for fedora !"
echo "by kumar-vaibhav (ijadux2)"

sleep 2

echo "system updates"
sudo dnf update

sleep 2
echo "installing vim "
sudo dnf install vim -y

echo ">>>installing shell (zsh) with oh my zsh"
sudo dnf install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohyzsh/ohmyzsh/master/tools/install.sh)"
echo "PROMPT='%F{cyan}%~%F{cyan} ➜ '" >>~/.zshrc

sleep 2
