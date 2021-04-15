# This .bash_profile is for macOS machines that I use.

export CLICOLOR=1
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export BASH_SILENCE_DEPRECATION_WARNING=1
set -o vi

# Prompt.
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# Bash completion.
if type brew &> /dev/null && [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# Aliases and machine-specific config.
source ~/.bash_aliases
source ~/.bash_local
