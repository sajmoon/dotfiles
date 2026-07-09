---
name: codex-review
description: Get an independent, second-opinion code review from the codex CLI (a different model) over the current branch's changes, then verify its findings against the diff. Triggers on "codex review", "review with codex", "get codex's opinion", "second opinion".
argument-hint: "[--base <branch> | --commit <sha>]"
---

# Codex Review

Run an external review via the `codex` CLI (a different model), then sanity-check what it says. A genuinely independent opinion is the whole point — present codex's findings, don't launder them.

Scope (`$ARGUMENTS`): explicit args win — `--base <branch>` reviews the whole branch vs. that base, `--commit <sha>` reviews one commit. With no args, **auto-pick**: if the working tree has uncommitted changes, review those (`--uncommitted`); if it's clean (work already committed, e.g. an open PR), review the branch against its base (`--base <base>`) so committed-only branches still get reviewed. Pick the base as the open PR's target if there is one (`gh pr view --json baseRefName`), else the remote default branch (`git symbolic-ref refs/remotes/origin/HEAD`); use the `origin/` ref so it isn't stale. Scope flags are mutually exclusive and, in this codex version, **cannot be combined with a positional prompt** — so don't pass review instructions as an argument; use codex's native output.

1. **Preflight** — `codex login status`; if not logged in, stop and tell the user to run `codex login`.

2. **Run** — run codex in the **background** (Bash `run_in_background`) so it isn't bound by the 10-min foreground limit, and wait for the completion notification. Use `high` effort: it's markedly more careful than low/medium (on a small diff it declined a false positive that medium reported as a P1) without the runaway slowness of the configured `xhigh` (which timed out at 300s on a whole branch). Backstop with a generous timeout so a stuck or wandering run can't linger:
   `timeout 900 codex review <scope> -c model_reasoning_effort=high` with the scope chosen above. Run that bare as the background command — don't append `echo`/other commands, or a trailing success overwrites codex's real exit code (124 on timeout). Runtime is dominated by how much codex explores, not diff size — expect ~30s to several minutes.

3. **On failure** — exit 124 (timeout) or any non-zero exit → report "codex review: timed out / unavailable" and stop. Never synthesize findings from codex's exploration trace.

4. **Present** — codex streams an exploration trace, then prints its review at the **end** as `[P<n>] <title> — <path:line>` findings with a paragraph each. Extract those final findings (ignore the trace), show them **verbatim**, then add a short note marking which hold up against the actual diff vs. look like false positives or stale context. Review-only — don't edit unless the user asks.
