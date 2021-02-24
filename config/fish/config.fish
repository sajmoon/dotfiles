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
source /usr/local/opt/asdf/asdf.fish

# set -x PATH $HOME/.fastlane/bin $PATH

