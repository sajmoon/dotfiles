---
name: make-ready
description: Get the current branch ready to push — parallel multi-agent review (security, code reuse, architecture, existing-pattern adherence, overengineering, correctness) over the pending diff, then /simplify, then push and shepherd through CI until green. Triggers on "make ready", "ready to push", "get this through CI".
argument-hint: "[--auto] [--no-push] [scope notes]"
---

# Make Ready

Take the current branch from written to ready-to-merge. Favor quality over speed.

Arguments (`$ARGUMENTS`): `--auto` skips the pre-push approval; `--no-push` stops after simplify; anything else is scope notes. Default: pause once for approval before the first push, then drive CI autonomously.

## Pipeline

1. **Scope** — diff everything not yet on the branch base (unpushed commits + working tree). Nothing to review → stop.

2. **Review** — spawn read-only agents concurrently (one message), one per lens, each returning findings as `severity · file:line · problem · fix`. Lenses: security, code reuse / DRY, architecture, adherence to existing patterns, overengineering, correctness.

3. **Triage & fix** — consolidate, rank, apply the clear fixes; flag judgment calls. Run quick local checks (tests / typecheck / lint) if available.

4. **Simplify** — run `/simplify` over the changes; sanity-check its edits.

5. **Push** (unless `--no-push`) — commit, then push the feature branch fast-forward. Unless `--auto`, confirm before the first push.

6. **CI** — watch via `gh` (PR checks, or the branch's latest run). On failure: read the failing logs, fix the root cause (never weaken tests or skip checks), push, re-watch; rerun flaky/infra failures instead of "fixing" them. Stop after ~3 cycles or a repeating failure and hand back. Report the final result + PR link.

Only the main agent edits — review agents never write. Never force-push or push to the default branch.
