# Dotfiles repo

- This repo is managed by [rcm](https://github.com/thoughtbot/rcm): files here are symlinked into `$HOME` (`zshrc` → `~/.zshrc`, `claude/settings.json` → `~/.claude/settings.json`); see README.md.
- After adding a file, run `rcup` to link it; docs are kept unlinked via `EXCLUDES` in `rcrc`.
- `GLOBAL_AGENTS.md` is the global, all-projects agent instructions file — it becomes `~/.claude/CLAUDE.md` (via the `claude/CLAUDE.md` symlink) and `~/.codex/AGENTS.md` + `~/.config/opencode/AGENTS.md` (via `hooks/post-up`). Only machine-independent, all-projects instructions go there.
- This file (`AGENTS.md`, with `.claude/CLAUDE.md` symlinked to it for Claude Code) holds dotfiles-specific instructions.
- rcm's `EXCLUDES` matches basenames: excluding top-level `AGENTS.md` excludes every nested `AGENTS.md` too, so files rcup can't link go in `hooks/post-up` instead.
