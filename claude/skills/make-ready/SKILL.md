---
name: make-ready
description: Get the current branch ready to push — run the built-in /code-review over the pending diff (with codex-review running in parallel as an external lens) and /simplify, then make-pr to push and shepherd CI until green. Triggers on "make ready", "ready to push". For just push/PR/CI without the review, use make-pr.
argument-hint: "[--auto] [--no-push] [scope notes]"
---

# Make Ready

Take the current branch from written to ready-to-merge. Favor quality over speed.

Arguments (`$ARGUMENTS`): `--auto` skips the pre-push approval; `--no-push` stops before the PR/CI step; anything else is scope notes. Default: pause once for approval before the first push, then drive CI autonomously.

## Pipeline

1. **Scope** — diff everything not yet on the branch base (unpushed commits + working tree). Nothing to review → stop.

2. **Kick off codex (background)** — start the external lens the way the `codex-review` skill does: `codex review --base <base> -c model_reasoning_effort=high` via Bash `run_in_background`, so it runs in parallel with the review and simplify steps below. Best-effort, never blocking — you collect it at triage; if codex isn't logged in, is still running then, times out, or exits non-zero, note "codex review: skipped" and carry on.

3. **Review** — run the built-in `/code-review` skill at high effort over the pending diff (correctness bugs plus reuse / simplify / efficiency cleanups). Let it surface findings; you apply them at triage.

4. **Simplify** — run `/simplify` over the changes; sanity-check its edits. (codex is still churning in parallel through steps 3–4.)

5. **Triage & fix** — fold in codex's findings (treat them as claims to verify against the diff — drop the false positives), consolidate with what `/code-review` surfaced, apply the clear fixes, flag judgment calls. Run quick local checks (tests / typecheck / lint) if available.

6. **PR & CI** (unless `--no-push`) — unless `--auto`, get a quick go-ahead before pushing anything; then invoke the `make-pr` skill (Skill tool) to commit, push, open the PR, and shepherd CI to green. Ensure the PR title and body reflect the final reviewed-and-simplified change, not a stale summary — update an existing PR's description if the diff has moved on.

Never force-push or push to the default branch.
