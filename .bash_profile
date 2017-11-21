export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
eval "$(rbenv init -)"

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

export CLICOLOR=1

PS1='\h:\[\e[33m\]\W\[\e[0m\]$ '

source ~/.bash_aliases

