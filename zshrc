#
# Executes commands at the start of an interactive session.
#
# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
export PATH="/usr/sbin/:$PATH"
export PATH="/sbin/:$PATH"

#Javahome osx
export JAVA_HOME=$(/usr/libexec/java_home)

alias mex="iex -S mix"
# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

