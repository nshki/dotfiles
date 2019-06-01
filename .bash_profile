# This .bash_profile is for macOS machines that I use.

export CLICOLOR=1
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
set -o vi

# Prompt.
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# Bash completion.
if type brew &> /dev/null && [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# rbenv.
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# nvm.
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"

# Aliases and machine-specific config.
source ~/.bash_aliases
source ~/.bash_local
