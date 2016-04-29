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
export PATH="/usr/sbin:$PATH"
export PATH="/sbin:$PATH"

alias mex="iex -S mix"

alias setjdk16='export JAVA_HOME=$(/usr/libexec/java_home -v 1.6)'
alias setjdk17='export JAVA_HOME=$(/usr/libexec/java_home -v 1.7)'
alias setjdk18='export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)'

# activate z
. /usr/local/etc/profile.d/z.sh

# History search
bindkey '^R' history-incremental-pattern-search-backward

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local


export PATH="$HOME/.bin:$PATH"
eval "$(rbenv init - --no-rehash)"
