#===============================================================================
#            _               _                           __ _ _
#           | |__   __ _ ___| |__       _ __  _ __ ___  / _(_) | ___
#           | '_ \ / _` / __| '_ \     | '_ \| '__/ _ \| |_| | |/ _ \
#          _| |_) | (_| \__ \ | | |    | |_) | | | (_) |  _| | |  __/
#         (_)_.__/ \__,_|___/_| |_|____| .__/|_|  \___/|_| |_|_|\___|
#                                |_____|_|
#
#
#    Table of contents
#    -----------------
#    1. Required .bash_profile additions for certain applications
#    2. General configuration
#    3. Prompt customization
#    4. Aliases
#
#    Sources
#    -------
#    1. Git status icons (http://goo.gl/VsKq6j)
#
#===============================================================================


#-------------------------------------------------------------------------------
# 1. Required .bash_profile additions for certain applications
#-------------------------------------------------------------------------------

eval "$(rbenv init -)"                         # rbenv
export PATH="/usr/local/bin:$PATH"             # brew doctor
export PATH="/usr/local/sbin:$PATH"            # brew doctor
export PATH="/usr/local/heroku/bin:$PATH"      # heroku

# bash_completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi


#-------------------------------------------------------------------------------
# 2. General configuration
#-------------------------------------------------------------------------------

export CLICOLOR=1   # enable colors

# # Print some big text on startup
# cat << 'EOF'
#  _               _
# | |__   __ _ ___| |__
# | '_ \ / _` / __| '_ \
# | |_) | (_| \__ \ | | |
# |_.__/ \__,_|___/_| |_|
# EOF


#-------------------------------------------------------------------------------
# 3. Prompt customization
#-------------------------------------------------------------------------------

ICON_CHANGES='\x26\x13'      # X
ICON_NO_CHANGES='\x27\x13'   # checkmark

# Accept a UTF-8 character code and display a UTF-16 version of that
# given character.
# @params $1 - UTF-8 character
# @return      UTF-16 version of $1
function get_icon {
  echo -ne $(echo -ne "$1" | iconv -f utf-16be)
}

# Display a checkmark or X depending on whether the current directory
# has changes waiting to be committed.
# @params   none
# @return   A UTF-16 icon
function parse_git_dirty {
  local NO_CHANGES="nothing to commit, working tree clean"
  if [[ $(git status 2> /dev/null | tail -n1) != "$NO_CHANGES" ]]; then
    get_icon $ICON_CHANGES
  else
    get_icon $ICON_NO_CHANGES
  fi
}

# Set the prompt
PS1='\
\n\
\h:\[\e[33m\]\W $(__git_ps1 "\[\e[36m\]{ %s $(parse_git_dirty) }")\n\
\[\e[0m\]$ '


#-------------------------------------------------------------------------------
# 4. Aliases
#-------------------------------------------------------------------------------

alias update="brew update && brew upgrade && brew cleanup"
alias bun="bundle exec"
alias migrate="bin/rails db:migrate && bin/rails db:migrate RAILS_ENV=test"
alias rakemigrate="bin/rake db:migrate && bin/rake db:migrate RAILS_ENV=test"
alias dbreset="bin/rails db:drop && bin/rails db:create && migrate && bin/rails db:seed"
alias rakereset="bin/rake db:drop && bin/rake db:create && rakemigrate && bin/rake db:seed"
