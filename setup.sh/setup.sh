#!/usr/bin/env bash

# setup configureation for ubuntu or debian based linux operating system !
#
# this setup.sh comprmize for dev setup !!

echo " >>> seting up your system by Kumar-vaibhav (ijadux2)"
sleep 10
echo " >>> updating and upgrading your system"
sudo apt update && sudo apt upgrade

echo " >>> instaiing important packages "

echo " >>> installing git curl and wget for later system installation ! "
sudo apt install git curl wget

sleep 10

echo " >>> installing terminal text editor for coding and file editing "
sleep 1echo " >>> installing vim"
sleep 1
echo " >>> if vim is already installed in your system preconfigured then this script will upgrade vim "
sudo apt install vim

sleep 10
echo " >>> making a dev-shell for development "
echo " >>> installing zsh and oh-my-zsh"
echo " >>> password is requieired for the further steps"
sleep 5
sudo apt install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "PROMPT='%F{cyan}%~%F{cyan} ➜ '" >>~/.zshrc
sleep 10
echo " >>> installing some terminal dependencies "
echo " >>> installing starship for prompt"
curl -sS https://starship.rs/install.sh | sh
#eval "$(starship init zsh)" >>~/.zshrc

sleep 10
echo " >>> installing zoxide ! "
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
eval "$(zoxide init zsh)" >>~/.zshrc
alias cd=z
sleep 10
echo " >>> installing fzf terminal-file manager "
sudo apt install fzf

echo " >>> sourcing the shell !"
source ~/.zshrc

sleep 10

echo " >>> making installation for pacstall (extra package-manager for debian/ubuntu) !"
sudo bash -c "$(curl -fsSL https://pacstall.dev/q/install)"

sleep 5

echo " >>> making install for terminal ghostty and fonts (JetBrians Mono Nerd fonts) and neovim for game-development !"
pacstall -I ghostty-app
pacstall -I nerd-fonts-jetbrains-mono
pacstall -I neovim
echo " >>> installing discord (vesktop) "
pacstall -I vesktop-deb

sleep 10

echo " >>> setting up neovim for development!"
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git

sleep 8
echo " >>> configure ghostty-terminal with my dotfiles (https://github.com/ijadux2/.dotfiles)"
sleep 20
echo " >>> learn the vim keybinding for game-development ansu"
echo " >>> customize your linux !"
echo " >>> for inspiration go and search (unixporn) on your broswer for ideas "
