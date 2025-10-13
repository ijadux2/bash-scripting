echo " >>> installing some terminal dependencies "
#echo " >>> installing starship for prompt"
#curl -sS https://starship.rs/install.sh | sh
#eval "$(starship init zsh)" >>~/.zshrc

sleep 3
echo " >>> installing zoxide ! "
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
eval "$(zoxide init zsh)" >>~/.zshrc
alias cd=z
sleep 3
echo " >>> installing fzf terminal-file manager "
sudo apt install fzf

echo " >>> sourcing the shell !"
source ~/.zshrc

sleep 3

echo " >>> making installation for pacstall (extra package-manager for debian/ubuntu) !"
sudo bash -c "$(curl -fsSL https://pacstall.dev/q/install)"

sleep 2

echo " >>> making install for terminal ghostty and fonts (JetBrians Mono Nerd fonts) and neovim for game-development !"
pacstall -I ghostty-app
pacstall -I nerd-fonts-jetbrains-mono
pacstall -I neovim
echo " >>> installing discord (vesktop) "
pacstall -I vesktop-deb

sleep 3

echo " >>> setting up neovim for development!"
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git

sleep ijadux2
echo " >>> configure ghostty-terminal with my dotfiles (https://github.com/ijadux2/.dotfiles)"
sleep 3
echo " >>> learn the vim keybinding for game-development ansu"
echo " >>> customize your linux !"
echo " >>> for inspiration go and search (unixporn) on your broswer for ideas "

