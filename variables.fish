# Local variables that is local to this machine only

set -x LC_ALL en_US.UTF-8
set -x LC_CTYPE en_US.UTF-8
set -x EDITOR nvim

# Configure for android development
set -x ANDROID_HOME $HOME/Library/Android/sdk
set -x ANDROID_SDK_ROOT $ANDROID_HOME
set -ax PATH $ANDROID_HOME/emulator
set -ax PATH $ANDROID_HOME/tools
set -ax PATH $ANDROID_HOME/tools/bin
set -ax PATH $ANDROID_HOME/platform-tools

if test -e ~/.variables_local.fish
  source ~/.variables_local.fish
end
