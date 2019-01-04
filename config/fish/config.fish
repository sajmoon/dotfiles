# Install fisher
# https://github.com/jorgebucaran/fisher

if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

# Delegate configuration to other files
source ~/.config.fish
source ~/.aliases.fish
source ~/.variables.fish

# set -gx ANDROID_HOME "/Users/simon/Library/Android/sdk"
# set -gx ANDROID_SDK_ROOT "/Users/simon/Library/Android/sdk"

# set PATH "$ANDROID_HOME/emulator" $PATH
# set PATH "$ANDROID_HOME/tools" $PATH
# set PATH "$ANDROID_HOME/tools/bin" $PATH
# set PATH "$ANDROID_HOME/platform-tools" $PATH

# set -x PATH $HOME/.fastlane/bin $PATH
