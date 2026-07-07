---
name: codex-review
description: Get an independent, second-opinion code review from the codex CLI (a different model) over the current branch's changes, then verify its findings against the diff. Triggers on "codex review", "review with codex", "get codex's opinion", "second opinion".
argument-hint: "[--base <branch> | --commit <sha>]"
---

# Codex Review

Run an external review via the `codex` CLI (a different model), then sanity-check what it says. A genuinely independent opinion is the whole point — present codex's findings, don't launder them.

Scope (`$ARGUMENTS`): explicit args win — `--base <branch>` reviews the whole branch vs. that base, `--commit <sha>` reviews one commit. With no args, **auto-pick**: if the working tree has uncommitted changes, review those (`--uncommitted`); if it's clean (work already committed, e.g. an open PR), review the branch against its base (`--base <base>`) so committed-only branches still get reviewed. Pick the base as the open PR's target if there is one (`gh pr view --json baseRefName`), else the remote default branch (`git symbolic-ref refs/remotes/origin/HEAD`); use the `origin/` ref so it isn't stale. Scope flags are mutually exclusive and, in this codex version, **cannot be combined with a positional prompt** — so don't pass review instructions as an argument; use codex's native output.

1. **Preflight** — `codex login status`; if not logged in, stop and tell the user to run `codex login`.

2. **Run** — codex at its configured `xhigh` effort is far too slow to finish (a 27-line diff didn't complete in 120s; a whole branch timed out at 300s with nothing). Force low effort and a hard timeout so a stuck run can't hang the session:
   `timeout 300 codex review <scope> -c model_reasoning_effort=low` with the scope chosen above. Capture codex's own exit code directly (`codex …; ec=$?`); don't wrap it so a trailing command masks the code. Expect ~1 min even on tiny diffs; larger scopes take proportionally longer.

3. **On failure** — exit 124 (timeout) or any non-zero exit → report "codex review: timed out / unavailable" and stop. Never synthesize findings from codex's exploration trace.

4. **Present** — codex streams an exploration trace, then prints its review at the **end** as `[P<n>] <title> — <path:line>` findings with a paragraph each. Extract those final findings (ignore the trace), show them **verbatim**, then add a short note marking which hold up against the actual diff vs. look like false positives or stale context. Review-only — don't edit unless the user asks.
