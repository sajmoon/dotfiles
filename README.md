# Dotfiles

Config files shared across machines, symlinked into `$HOME` with
[rcm](https://github.com/thoughtbot/rcm).

## Setup

Install rcm, then from anywhere run:

```sh
RCRC=$HOME/.dotfiles/rcrc rcup
```

The `RCRC=` prefix is only needed on the first run, before `~/.rcrc` itself is
linked; after that a plain `rcup` works.

## How it works

- A file `foo` in this repo is linked to `~/.foo`: `zshrc` → `~/.zshrc`,
  `claude/settings.json` → `~/.claude/settings.json`, `config/nvim/...` →
  `~/.config/nvim/...`, `config/opencode/...` → `~/.config/opencode/...`,
  `bin/...` → `~/.bin/...`.
- Linking is file-level: directories are created for real and each file inside
  is a symlink. After adding a file to the repo, re-run `rcup` to link it.
- To adopt an existing file from `$HOME` into the repo, use `mkrc ~/.somefile`.
- `lsrc` lists everything rcm manages; `EXCLUDES` in `rcrc` keeps docs like
  this one from being linked.

## Agent instruction files

- `GLOBAL_AGENTS.md` — instructions for ALL projects. Reaches each harness
  three ways: `~/.claude/CLAUDE.md` via the `claude/CLAUDE.md` symlink, and
  `~/.codex/AGENTS.md` + `~/.config/opencode/AGENTS.md` via `hooks/post-up`
  (which rcup runs automatically).
- `AGENTS.md` — instructions for this repo only; `.claude/CLAUDE.md` symlinks
  to it so Claude Code reads it too.
- Gotcha: rcm's `EXCLUDES` matches basenames, so excluding the top-level
  `AGENTS.md` also excludes any nested file with that name — that's why the
  codex/opencode links live in the hook instead of being rcup-managed files.

## Agent skills

Skills are `<name>/SKILL.md` directories, and they live in one of two trees
depending on which harnesses can actually run them:

- `agents/skills/` — shared. Claude Code, Codex, and opencode all pick these
  up. Add one, run `rcup`, done. Keep them free of harness-specific tools.
- `claude/skills/` — Claude Code only, for skills that lean on its built-ins
  (`/code-review`, `/simplify`, the `Skill` tool, `run_in_background`).

`hooks/post-up` does the fan-out, because the two harnesses disagree about
symlinks. Codex ignores a skill whose `SKILL.md` is a symlink but happily
follows a symlinked directory, so the hook points `~/.agents/skills` (which
Codex and opencode both scan) at `agents/skills` wholesale, and `agents/skills`
is in `EXCLUDES` to keep rcup from file-linking it first. Claude Code reads
only `~/.claude/skills` and does follow symlinked files, so the hook mirrors
the shared tree in file by file, leaving room for the Claude-only skills rcup
 links into the same directory.

## OpenCode agents

- `config/opencode/agent/cheap-builder.md` — DeepSeek V4 Flash via OpenRouter
  for well-scoped implementation work.
- `config/opencode/agent/gpt-builder.md` — GPT for complex or high-risk
  implementation work.
- Use a primary agent to plan and review. Delegate implementation with
  `@cheap-builder` or `@gpt-builder`. OpenRouter and OpenAI credentials are
  configured separately with `/connect` and are not stored in this repo.
