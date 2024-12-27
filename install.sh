#!/bin/bash

# Set up development directory.
read -p "Enter absolute path to dev directory [~/dev]: " dev_dir
dev_dir=${dev_dir:-~/dev}
mkdir -p $dev_dir

# Clone dotfiles repository.
[ -d $dev_dir/dotfiles ] || git clone https://github.com/nshki/dotfiles.git $dev_dir/dotfiles

# Ensure CLT for Xcode are installed.
xcode-select --install

# Install Homebrew and bundle.
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
brew bundle --file=$dev_dir/dotfiles/config/Brewfile

# Bash config.
[ ! -f ~/.bash_local ] && touch ~/.bash_local
rm -f ~/.bash_aliases && ln -s $dev_dir/dotfiles/config/.bash_aliases ~/.bash_aliases
rm -f ~/.bash_profile && ln -s $dev_dir/dotfiles/config/.bash_profile ~/.bash_profile
source ~/.bash_profile

# Switch default shell to Homebrew Bash.
sudo bash -c 'echo "/opt/homebrew/bin/bash" >> /etc/shells'
chsh -s /opt/homebrew/bin/bash

# Ghostty config.
ghostty_config_dir=~/Library/Application\ Support/com.mitchellh.ghostty
mkdir -p "$ghostty_config_dir"
[ ! -f "$ghostty_config_dir/config" ] && touch "$ghostty_config_dir/config"
rm -f "$ghostty_config_dir/config" && ln -s "$dev_dir/dotfiles/config/ghostty_config" "$ghostty_config_dir/config"

# Install Node and Ruby.
nodenv install 22.11.0
nodenv global 22.11.0
rbenv install 3.3.6
rbenv global 3.3.6

# Install LazyVim.
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git

# Setup Git.
read -p "Enter Git name: " git_name
read -p "Enter Git email: " git_email
git config --global user.name "$git_name"
git config --global user.email $git_email
git config --global core.editor nvim

# Setup SSH key with GitHub.
#
# Ref: https://help.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
if [ ! -f ~/.ssh/id_rsa ]; then
  read -p "Enter GitHub email address: " github_email
  ssh-keygen -t rsa -b 4096 -C $github_email
fi
eval "$(ssh-agent -s)"
cp $dev_dir/dotfiles/config/sshconfig ~/.ssh/config
ssh-add -K ~/.ssh/id_rsa
pbcopy <~/.ssh/id_rsa.pub
read -p "SSH key copied to clipboard. Add to GitHub (https://github.com/settings/keys). Press enter when done."
