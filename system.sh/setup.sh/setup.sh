#!/usr/bin/env bash

# setup configuration for ubuntu or debian based linux operating system !
#
# this setup.sh comprmize for dev setup !!
#
# this is for normal configuration for starters which are contributing in linux and various linux based felids
#
# build by ijadux2 (Kumar-vaibhav)
#
echo " >>> seting up your system by Kumar-vaibhav (ijadux2)"
echo " >>> password is requieired for this operation "
echo " >>> this configuration is minimal and default if you have to customize then customize it latter after the script ! "
sleep 2
echo " >>> updating and upgrading your system"
sudo apt update && sudo apt upgrade

echo " >>> instaiing important packages "

echo " >>> installing git curl and wget for later system installation ! "
sudo apt install git curl wget

sleep 3

echo " >>> installing terminal text editor for coding and file editing "
sleep 1echo " >>> installing vim"
sleep 1
echo " >>> if vim is already installed in your system preconfigured then this script will upgrade vim "
sudo apt install vim

sleep 3
echo " >>> making a dev-shell for development "
echo " >>> installing zsh and oh-my-zsh"
echo " >>> password is requieired for the further steps"
sleep 2
sudo apt install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sleep 4

echo "for furture setup"
source ./additional-pkgs.sh 

#echo " >>> installing some terminal dependencies "
#echo " >>> installing starship for prompt"
#curl -sS https://starship.rs/install.sh | sh
#eval "$(starship init zsh)" >>~/.zshrc
