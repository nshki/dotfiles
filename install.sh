#!/bin/bash

# Set up development directory.
read -p "Enter absolute path to dev directory [~/dev]: " dev_dir
dev_dir=${dev_dir:-~/dev}
mkdir -p $dev_dir

# OS selection.
while [[ $os != "debian" && $os != "macos" ]]; do
  read -p "What OS are you using? [debian|macos]: " os
done

# Clone dotfiles repository.
[ -d $dev_dir/dotfiles ] || git clone https://github.com/nshki/dotfiles.git $dev_dir/dotfiles

# Install apps.
if [[ $os == "debian" ]]; then
  bash $dev_dir/dotfiles/config/debian/install_apps.sh
elif [[ $os == "macos" ]]; then
  # Ensure CLT for Xcode are installed.
  xcode-select --install

  # Install Homebrew and bundle.
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew bundle --file=$dev_dir/dotfiles/config/macos/Brewfile
fi

# Install tpm.
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Symlink and configure dotfiles.
[ ! -f ~/.bash_local ] && touch ~/.bash_local
mkdir -p ~/.config/nvim
rm -f ~/.config/nvim/init.vim && ln -s $dev_dir/dotfiles/config/init.vim ~/.config/nvim/init.vim
rm -f ~/.config/nvim/coc-settings.json && ln -s $dev_dir/dotfiles/config/coc-settings.json ~/.config/nvim/coc-settings.json
rm -f ~/.bash_aliases && ln -s $dev_dir/dotfiles/config/.bash_aliases ~/.bash_aliases
rm -f ~/.gitignore_global && ln -s $dev_dir/dotfiles/config/.gitignore_global ~/.gitignore_global
rm -f ~/.tmux.conf && ln -s $dev_dir/dotfiles/config/.tmux.conf ~/.tmux.conf
rm -f ~/.tmuxline && ln -s $dev_dir/dotfiles/config/.tmuxline ~/.tmuxline
if [[ $os == "debian" ]]; then
  echo "set -o vi" >> ~/.bashrc
elif [[ $os == "macos" ]]; then
  rm -f ~/.bash_profile && ln -s $dev_dir/dotfiles/config/macos/.bash_profile ~/.bash_profile
fi

# Install `vim-plug` for Neovim.
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

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
  xclip -sel clip < ~/.ssh/id_rsa.pub
elif [[ $os == "macos" ]]; then
  cp $dev_dir/dotfiles/config/sshconfig ~/.ssh/config
  ssh-add -K ~/.ssh/id_rsa
  pbcopy < ~/.ssh/id_rsa.pub
fi
read -p "SSH key copied to clipboard. Add to GitHub (https://github.com/settings/keys). Press enter when done."
