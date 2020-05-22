# Prep APT.
sudo apt update && sudo apt upgrade && sudo apt autoremove

# Prep base build packages.
sudo apt install bash bash-completion build-essential curl git

# Add APT apps.
sudo apt install fonts-firacode gconf2 gnome-terminal hub neofetch neovim postgresql redis silversearcher-ag tmux xclip

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
