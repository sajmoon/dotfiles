---
name: make-pr
description: Push the current branch, open a PR if none exists, and shepherd it through CI, fixing failures until green. Lightweight — no review pass; use make-ready for that. Triggers on "make pr", "make a pr", "push and open a PR", "get this through CI".
argument-hint: "[notes]"
---

# Make PR

Get the current work onto a PR and drive it green. No review pass — just ship what's here.

1. **Branch** — never push the default branch: if on main/master, create a feature branch named after the change and continue there. Never force-push.

2. **Commit** — commit pending work in coherent commits per repo conventions. **Never add LLM attribution** (no `Co-Authored-By`, no "Generated with").

3. **Push** — `git push -u origin HEAD`, fast-forward only.

4. **PR** — reuse the branch's open PR if one exists; otherwise `gh pr create` with a concise title and body summarizing the change. Either way, verify the title and body accurately describe the *current* diff — if reusing a PR whose description has gone stale (the change grew or shifted since it was opened), rewrite it with `gh pr edit`.

5. **CI** — `gh pr checks --watch --interval 30`; if the shell timeout cuts the watch, poll `gh pr checks` again. On failure: read the failing logs (`gh run view <id> --log-failed`), fix the root cause — never delete/weaken a test, skip a check, or use `--no-verify` — commit, push, re-watch. Flaky or infra failures get `gh run rerun --failed` instead of a "fix"; pre-existing or unrelated breakage gets surfaced, not absorbed. Stop after ~3 fix cycles or a repeating failure and hand back with your diagnosis.

6. **Report** — CI result, PR link, what changed.
