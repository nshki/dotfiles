# Prep APT.
sudo apt update && sudo apt upgrade && sudo apt autoremove

# Prep base build packages.
sudo apt install bash bash-completion build-essential curl git snap

# Add APT apps.
sudo apt install fonts-hack-ttf gnome-terminal neofetch neovim postgresql redis silversearcher-ag tmux xclip

# Add Snap apps.
sudo snap install firefox
sudo snap install --classic slack heroku hub

# Install nvm.
#
# Ref: https://github.com/nvm-sh/nvm#install--update-script
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash

# Install rbenv.
#
# Ref: https://github.com/rbenv/rbenv-installer#rbenv-installer
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer | bash

# Install Yarn.
#
# Ref: https://yarnpkg.com/en/docs/install#debian-stable
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update && sudo apt install --no-install-recommends yarn
