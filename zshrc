#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
#export GEM_HOME='/usr/local/Cellar/gems/1.8'

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# z terminal navigation
# assumes z installed.
. `brew --prefix`/etc/profile.d/z.sh

# GOPATHs
# export GOPATH="${HOME}/go"
# export GOBIN="${HOME}/go"
# export PATH=$PATH:/$GOBIN/bin
# export PATH=$PATH:$GOPATH:$GOBIN

#Javahome osx
export JAVA_HOME=$(/usr/libexec/java_home)

# Docker env
# export DOCKER_HOST=tcp://192.168.59.103:2376
# export DOCKER_CERT_PATH=/Users/simon/.boot2docker/certs/boot2docker-vm
# export DOCKER_TLS_VERIFY=1
#

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
