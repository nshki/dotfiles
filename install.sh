#!/bin/bash

# Set up development directory.
read -p "Enter absolute path to dev directory [~/dev]: " dev_dir
dev_dir=${dev_dir:-~/dev}
mkdir -p $dev_dir

# OS selection.
while [[ $os != "debian" && $os != "macos" ]]
do
  read -p "What OS are you using? [debian|macos]: " os
done

# Install apps.
if [[ $os == "debian" ]]; then
  bash $dev_dir/dotfiles/config/debian/install_apps.sh
elif [[ $os == "macos" ]]; then
  # Ensure CLT for Xcode are installed.
  xcode-select --install

  # Install Homebrew and bundle.
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew bundle --file $dev_dir/dotfiles/config/macos/Brewfile
fi

# Install tpm.
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Configure nvim to use .vimrc.
mkdir -p ~/.config/nvim
cp $dev_dir/dotfiles/config/init.vim ~/.config/nvim

# Clone dotfiles repository.
[ -d $dev_dir/dotfiles ] || git clone https://github.com/nshki/dotfiles.git $dev_dir/dotfiles

# Add Terminal themes.
if [[ $os == "debian" ]]; then
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/denysdovhan/gnome-terminal-one/master/one-dark.sh)"
elif [[ $os == "macos" ]]; then
  open $dev_dir/dotfiles/config/macos/shikidark.terminal
fi

# Symlink and configure dotfiles.
[ -f ~/.bash_local ] || touch ~/.bash_local
rm -f ~/.bash_aliases && ln -s $dev_dir/dotfiles/config/.bash_aliases ~/.bash_aliases
rm -f ~/.gitignore_global && ln -s $dev_dir/dotfiles/config/.gitignore_global ~/.gitignore_global
rm -f ~/.tmux.conf && ln -s $dev_dir/dotfiles/config/.tmux.conf ~/.tmux.conf
rm -f ~/.tmuxline && ln -s $dev_dir/dotfiles/config/.tmuxline ~/.tmuxline
rm -f ~/.vimrc && ln -s $dev_dir/dotfiles/config/.vimrc ~/.vimrc
if [[ $os == "debian" ]]; then
  echo -e "\nset -o vi" >> ~/.bashrc
  echo -e '\nPATH="~/.rbenv/bin:$PATH"' >> ~/.bashrc
elif [[ $os == "macos" ]]; then
  rm -f ~/.bash_profile && ln -s $dev_dir/dotfiles/config/macos/.bash_profile ~/.bash_profile
fi

# Setup Git.
read -p "Enter Git name: " git_name
read -p "Enter Git email: " git_email
git config --global user.name "$git_name"
git config --global user.email $git_email
git config --global core.editor nvim
git config --global core.excludesfile ~/.gitignore_global

# Setup SSH key with GitHub.
#
# Ref: https://help.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
if [ ! -f ~/.ssh/id_rsa ]; then
  read -p "Enter GitHub email address: " github_email
  ssh-keygen -t rsa -b 4096 -C $github_email
fi
eval "$(ssh-agent -s)"
if [[ $os == "debian" ]]; then
  eval "$(ssh-agent -s)"
  xclip -sel clip < ~/.ssh/id_rsa.pub
elif [[ $os == "macos" ]]; then
  cp $dev_dir/dotfiles/config/sshconfig ~/.ssh/config
  ssh-add -K ~/.ssh/id_rsa
  pbcopy < ~/.ssh/id_rsa.pub
fi
read -p "SSH key copied to clipboard. Add to GitHub (https://github.com/settings/keys). Press enter when done."
