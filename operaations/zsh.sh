#!/usr/bin/bash

# edit this lines for installations of shell:zsh
#sudo dnf install zsh

# this is for installations of zsh in fedora !!
#
# zsh config in bash
#
#
# zsh in bash-scrpiting

read -p "shell-zsh (y,n,) >> " source

if [[ $source == y ]]; then
  #source ~/.zshrc
  zsh
else
  command chsh -s $(which zsh)
  zsh
fi

# zsh config for shell
#export ZSH="$HOME/. oh-my-zsh"
#ZSH_THEME="robbyrussel"
#plugins=(
#  zsh-autosuggestions
#  zsh-syntax-highlighting
#  zoxide
#  starship
#)
#
#aliases=(
#  cd="z"
#  v="nvim"
#  ls="lsd"
#  rm="rm -rf"
#  e="exit"
#)
