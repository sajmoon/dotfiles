---
name: make-ready
description: Get the current branch ready to push — run a parallel multi-agent code review (security, code reuse, architecture, existing-pattern adherence, overengineering, correctness) over the pending diff, then /simplify, then push and shepherd the change through CI, fixing failures until green. Use before pushing to CI, or when the user says "make ready", "make this ready", "ready to push", "review and push", or "get this through CI".
argument-hint: "[--auto] [--no-push] [scope notes]"
---

# Make Ready

Take the work on the current branch from "written" to "ready to merge": review it
hard, simplify it, then push and drive it green through CI. Bias toward quality
over speed (see the repo's AGENTS.md / `~/.claude/CLAUDE.md`) — better to spend
extra cycles and ship something clean than to rush a fragile change through.

## Arguments

`$ARGUMENTS` may contain:
- `--auto` — do not stop for approval before the first push; run the whole pipeline autonomously.
- `--no-push` — do review + simplify only, then stop before committing/pushing (local "make ready").
- anything else — freeform scope notes (e.g. "focus on the auth changes").

Default (no flags): pause once for a quick approval before the first push, then drive CI autonomously.

## Guardrails (apply throughout)

- Follow the repo's AGENTS.md / CLAUDE.md. **Never add LLM attribution to commits** (no `Co-Authored-By`, no "Generated with").
- Review agents are **read-only**. Only you (the main agent) edit files.
- **Never** fix a CI failure by deleting or weakening a test, skipping a check, or using `--no-verify`. Fix the root cause. If a test itself is genuinely wrong, stop and say so.
- **Never force-push**, and never push to the default branch. Only fast-forward pushes to the current feature branch.
- Distinguish failures caused by *this* change from pre-existing or flaky ones. Don't silently absorb unrelated breakage.
- Announce each phase boundary: what you found, what you're doing next.

## Phase 1 — Scope the diff

1. Find the base: `git merge-base HEAD origin/HEAD` (fall back to `origin/main`, then `origin/master`).
2. The review target is everything not yet on the base: unpushed commits **plus** uncommitted work. Gather it with `git diff <base>...HEAD`, `git diff` (unstaged), and `git diff --cached`.
3. List the changed files with a one-line summary of the change. If there's nothing to review, say so and stop.

## Phase 2 — Parallel multi-agent review

Launch these review agents **concurrently, in a single message** (Agent tool, `general-purpose`). Give each the base ref and the changed-file list; tell it to read the diff and the surrounding code it needs, and to **return findings only, no edits**. Require each finding to have: severity (`blocker` / `high` / `medium` / `low`), `file:line`, the problem, and a concrete fix.

One agent per lens:

1. **Security** — injection, authz/authn gaps, secret leakage, unsafe deserialization / `eval`, SSRF, unvalidated input, dependency & supply-chain risk.
2. **Code reuse / DRY** — duplicated logic, or reinventing a utility that already exists in this repo or its dependencies.
3. **Architecture** — separation of concerns, coupling, data flow, error handling, boundaries, testability.
4. **Existing-pattern adherence** — does this match conventions already used in this codebase (naming, file layout, libraries, error-handling style)? Flag divergence, and prefer the established pattern.
5. **Overengineering** — premature abstraction, needless generality/configurability, YAGNI, dead flexibility. Recommend the simpler shape.
6. **Correctness** — real bugs: edge cases, off-by-one, null/undefined, async/await mistakes, resource leaks, incorrect logic.

## Phase 3 — Triage & fix

1. Merge the findings, dedupe, and rank by severity.
2. Present a concise consolidated report (grouped by severity or lens).
3. Apply the fixes that are clearly correct — all blockers/high and any obvious cleanup. For genuine judgment calls (architecture trade-offs, ambiguous items), state your recommendation and proceed if low-risk; ask if it's consequential.
4. If quick, run the affected path plus local checks (tests / typecheck / lint) to confirm nothing broke.

## Phase 4 — Simplify

Run the `/simplify` skill over the changes to apply reuse/simplification/efficiency/altitude cleanups. Review its edits for correctness before continuing.

## Phase 5 — Commit & push

If `--no-push`, stop here and summarize what was reviewed, fixed, and simplified.

1. Stage and commit in coherent, self-contained commits with clear messages (no LLM attribution).
2. Unless `--auto`: show a summary of exactly what will be pushed and get a quick go-ahead.
3. Push the feature branch, fast-forward only: `git push -u origin HEAD`.

## Phase 6 — Shepherd through CI

1. Locate the run for this branch and wait for it:
   - If a PR exists: `gh pr checks --watch --interval 30` (blocks; exits non-zero if any check fails).
   - Else: `gh run list --branch "$(git branch --show-current)" --limit 1 --json databaseId,status,conclusion,workflowName`, then `gh run watch <id> --exit-status --interval 20`.
   - If CI only runs on PRs and none exists, offer to open one (`gh pr create`) rather than assuming.
   - `gh run watch` streams until CI finishes; if it exceeds the shell timeout, re-check with `gh run view <id> --json status,conclusion` and keep watching.
2. **Green** → report success (CI result + PR link) and stop.
3. **Failed**:
   - Pull failing logs: `gh run view <id> --log-failed`.
   - Diagnose:
     - Flaky / infra → `gh run rerun --failed`, then re-watch.
     - Real failure from this change → fix the **root cause**, commit (no attribution), push, and loop back to step 1.
     - Pre-existing / unrelated → surface it clearly; don't quietly fix around it.
   - Bound the loop: after ~3 fix cycles, or if the same failure recurs unchanged, stop and hand back to the user with your diagnosis.
4. Report final status: CI result, PR link, and a short list of what changed.
