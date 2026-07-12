# Dotfiles repo

- This repo is managed by [rcm](https://github.com/thoughtbot/rcm): files here are symlinked into `$HOME` (`zshrc` → `~/.zshrc`, `claude/settings.json` → `~/.claude/settings.json`); see README.md.
- After adding a file, run `rcup` to link it; docs are kept unlinked via `EXCLUDES` in `rcrc`.
- `GLOBAL_AGENTS.md` is the global, all-projects agent instructions file — it becomes `~/.claude/CLAUDE.md` (via the `claude/CLAUDE.md` symlink) and `~/.codex/AGENTS.md` + `~/.config/opencode/AGENTS.md` (via `hooks/post-up`). Only machine-independent, all-projects instructions go there.
- This file (`AGENTS.md`, with `.claude/CLAUDE.md` symlinked to it for Claude Code) holds dotfiles-specific instructions.
- rcm's `EXCLUDES` matches basenames: excluding top-level `AGENTS.md` excludes every nested `AGENTS.md` too, so files rcup can't link go in `hooks/post-up` instead.
- Skills live in one of two places. `agents/skills/` is for skills every harness can run — Codex and opencode read them from `~/.agents/skills`, Claude Code from `~/.claude/skills`. `claude/skills/` is for skills that depend on Claude Code itself (built-in slash commands like `/code-review`, the `Skill` tool, `run_in_background`); those would only misfire elsewhere.
- A shared skill must not reference anything harness-specific. Adding one is just a new `agents/skills/<name>/SKILL.md` plus `rcup`.
- `claude/settings.json` is live harness state (symlinked into `~/.claude`): Claude Code writes the `/model` choice back into it. The model pin must never be committed — a clean filter (`.gitattributes` + `[filter "claude-settings"]` in `gitconfig`, needs `jq`) strips the `model` key on stage, so `git diff`/`status` ignore it automatically.
- Codex silently skips a skill whose `SKILL.md` is a symlink, but it follows a symlinked *directory*. rcup only ever links file by file, so `agents/skills` sits in `EXCLUDES` and `hooks/post-up` symlinks the directory into `~/.agents/skills` itself. Claude Code does follow symlinked files, so the same hook mirrors the tree into `~/.claude/skills` file by file — a directory symlink there would shadow the Claude-only skills rcup puts alongside it.
