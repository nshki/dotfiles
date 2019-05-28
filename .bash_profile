# This .bash_profile is for macOS machines that I use.

export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"

# Setup bash completion
if type brew &> /dev/null && [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# Initialize rbenv
eval "$(rbenv init -)"

# Colors pls
export CLICOLOR=1

# Minimal prompt
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# Enable VI mode in bash by default
set -o vi

# Aliases and machine-specific config
source ~/.bash_aliases
source ~/.bash_local

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
