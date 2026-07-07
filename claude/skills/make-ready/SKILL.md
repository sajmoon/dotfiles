---
name: make-ready
description: Get the current branch ready to push — parallel multi-agent review (security, code reuse, architecture, existing-pattern adherence, overengineering, correctness) over the pending diff, then /simplify, then make-pr to push and shepherd CI until green. Triggers on "make ready", "ready to push". For just push/PR/CI without the review, use make-pr.
argument-hint: "[--auto] [--no-push] [scope notes]"
---

# Make Ready

Take the current branch from written to ready-to-merge. Favor quality over speed.

Arguments (`$ARGUMENTS`): `--auto` skips the pre-push approval; `--no-push` stops after simplify; anything else is scope notes. Default: pause once for approval before the first push, then drive CI autonomously.

## Pipeline

1. **Scope** — diff everything not yet on the branch base (unpushed commits + working tree). Nothing to review → stop.

2. **Review** — spawn read-only agents concurrently (one message), one per lens, each returning findings as `severity · file:line · problem · fix`. Lenses: security, code reuse / DRY, architecture, adherence to existing patterns, overengineering, correctness. In parallel, kick off an **external lens** the way the `codex-review` skill does — `codex review --base <base> -c model_reasoning_effort=low` in the background (Bash `run_in_background`; low effort so it actually finishes — its configured xhigh times out on a real branch). Best-effort, ~4 min cap: if codex isn't logged in, times out, or exits non-zero, note "codex review: skipped" and carry on. Never block the pipeline on it.

3. **Triage & fix** — consolidate all lenses, including codex's (treat its comments as claims to verify against the diff, not gospel — drop the false positives), rank, apply the clear fixes; flag judgment calls. Run quick local checks (tests / typecheck / lint) if available.

4. **Simplify** — run `/simplify` over the changes; sanity-check its edits.

5. **PR & CI** (unless `--no-push`) — unless `--auto`, get a quick go-ahead before pushing anything; then invoke the `make-pr` skill (Skill tool) to commit, push, open the PR, and shepherd CI to green.

Only the main agent edits — review agents never write. Never force-push or push to the default branch.
