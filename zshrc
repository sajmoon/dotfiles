# zshrc — managed by rcm (~/.zshrc -> ~/.dotfiles/zshrc)

# ── Auto-start tmux ────────────────────────────────────────────────
# Attach to a shared "main" session (create it if absent) whenever we
# open an interactive shell that isn't already inside tmux. `exec`
# replaces this shell so detaching/exiting tmux closes the terminal.
# Guards: skip non-interactive shells, nested tmux, and editor/VS Code
# integrated terminals so they don't get hijacked.
if command -v tmux >/dev/null 2>&1 \
   && [[ -o interactive ]] \
   && [[ -z "$TMUX" ]] \
   && [[ "$TERM_PROGRAM" != "vscode" ]] \
   && [[ -z "$INSIDE_EMACS" ]]; then
  exec tmux new-session -A -s main
fi

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Prompt is provided by Starship (see end of file); leave the oh-my-zsh theme
# empty so it doesn't draw its own prompt first.
ZSH_THEME=""

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

# Starship prompt — single binary, identical on macOS and WSL/Linux.
# Config lives in the repo at ~/.config/starship.toml. Install per machine:
#   macOS:  brew install starship
#   Linux:  curl -sS https://starship.rs/install.sh | sh -s -- -b ~/.local/bin
command -v starship >/dev/null && eval "$(starship init zsh)"
