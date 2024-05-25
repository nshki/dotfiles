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

# tmux and tpm config.
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
rm -f ~/.tmux.conf && ln -s $dev_dir/dotfiles/config/.tmux.conf ~/.tmux.conf
rm -f ~/.tmuxline && ln -s $dev_dir/dotfiles/config/.tmuxline ~/.tmuxline

# Programming languages.
curl --proto "=https" --tlsv1.2 -sSf https://sh.rustup.rs | sh
nodenv install 18.16.0
nodenv global 18.16.0
pyenv install 3.10.5
pyenv global 3.10.5
CFLAGS="-Wno-error=implicit-function-declaration" rbenv install 3.2.2
rbenv global 3.2.2

# Install LunarVim.
LV_BRANCH='release-1.4/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.4/neovim-0.9/utils/installer/install.sh)

# Install kitty.
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
git clone --depth 1 https://github.com/dexpota/kitty-themes.git ~/.config/kitty/kitty-themes
rm -f ~/.config/kitty/theme.conf && ln -s ~/.config/kitty/kitty-themes/themes/OneDark.conf ~/.config/kitty/theme.conf
rm -f ~/.config/kitty/kitty.conf && ln -s $dev_dir/dotfiles/config/kitty.conf ~/.config/kitty/kitty.conf

# Setup Git.
read -p "Enter Git name: " git_name
read -p "Enter Git email: " git_email
git config --global user.name "$git_name"
git config --global user.email $git_email
git config --global core.editor lvim

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
pbcopy < ~/.ssh/id_rsa.pub
read -p "SSH key copied to clipboard. Add to GitHub (https://github.com/settings/keys). Press enter when done."
