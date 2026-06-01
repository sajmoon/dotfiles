# zshrc — managed by rcm (~/.zshrc -> ~/.dotfiles/zshrc)

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# ── User configuration ─────────────────────────────────────────────

# PATH: user-local bins (zoxide, language toolchains, etc.)
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

# Git worktree helpers — `wt` (from dotfiles). oh-my-zsh already ran
# compinit above, so the `compdef` inside this file works.
[ -f "$HOME/.zsh_worktree" ] && source "$HOME/.zsh_worktree"

# zoxide — `z <dir>` jump to frecent directories
command -v zoxide >/dev/null && eval "$(zoxide init zsh)"
