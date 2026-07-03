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
  `~/.config/nvim/...`, `bin/...` → `~/.bin/...`.
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
