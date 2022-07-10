export BASH_SILENCE_DEPRECATION_WARNING=1
export CLICOLOR=1
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"
set -o vi

# Prompt.
PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "

# Bash completion.
if type brew &> /dev/null && [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# Homebrew package init.
eval "$(brew shellenv)"
eval "$(nodenv init -)"
eval "$(pyenv init -)"
eval "$(rbenv init -)"

# Version manager init.
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
. "$HOME/.cargo/env"

# Aliases and machine-specific config.
source ~/.bash_aliases
source ~/.bash_local
