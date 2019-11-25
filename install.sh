#!/bin/bash

# Set up development directory.
read -p "Enter absolute path to dev directory [~/dev]: " dev_dir
dev_dir=${dev_dir:-~/dev}
[ -d $dev_dir ] || mkdir $dev_dir
cd $dev_dir

# Clone dotfiles repository.
[ -d $dev_dir/dotfiles ] || git clone https://github.com/nshki/dotfiles.git
cd $dev_dir/dotfiles

# Ensure CLT for Xcode are installed.
xcode-select --install

# Install Homebrew and bundle.
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
cd $dev_dir/dotfiles/config/macos/
brew bundle
cd $dev_dir

# Symlink dotfiles.
[ -f ~/.bash_local ] || touch ~/.bash_local
rm ~/.bash_aliases && ln -s $dev_dir/dotfiles/config/.bash_aliases ~/.bash_aliases
rm ~/.bash_profile && ln -s $dev_dir/dotfiles/config/macos/.bash_profile ~/.bash_profile
rm ~/.gitignore_global && ln -s $dev_dir/dotfiles/config/.gitignore_global ~/.gitignore_global
rm ~/.tmux.conf && ln -s $dev_dir/dotfiles/config/.tmux.conf ~/.tmux.conf
rm ~/.tmuxline && ln -s $dev_dir/dotfiles/config/.tmuxline ~/.tmuxline
rm ~/.vimrc && ln -s $dev_dir/dotfiles/config/.vimrc ~/.vimrc

# Configure nvim to use .vimrc.
mkdir -p ~/.config/nvim
cp $dev_dir/dotfiles/config/init.vim ~/.config/nvim

# Install tpm.
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Add Terminal theme.
open $dev_dir/dotfiles/config/macos/shikidark.terminal

# Setup Git.
read -p "Enter Git name: " git_name
read -p "Enter Git email: " git_email
git config --global user.name $git_name
git config --global user.email $git_email
git config --global core.excludesfile ~/.gitignore_global

# Setup SSH key with GitHub.
#
# Ref: https://help.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
if [ ! -f ~/.ssh/id_rsa ]; then
  read -p "Enter GitHub email address: " github_email
  ssh-keygen -t rsa -b 4096 -C $github_email
fi
eval "$(ssh-agent -s)"
cp config/sshconfig ~/.ssh/id_rsa
ssh-add -K ~/.ssh/id_rsa
pbcopy < ~/.ssh/id_rsa.pub
read -p "SSH key copied to clipboard. Add to GitHub (https://github.com/settings/keys). Press enter when done."
