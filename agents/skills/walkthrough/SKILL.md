---
name: walkthrough
description: Turn a branch or PR diff into a guided HTML walkthrough a reviewer can follow without reading every line — intent, reasoning and assumptions, a change map, an ordered tour of the hunks that matter, behaviour before/after, and what to check. Triggers on "walkthrough", "walk me through this PR", "explain this diff", "review tour".
argument-hint: "[PR number | branch | base...head]"
---

# Walkthrough

Build one self-contained HTML page that teaches a change in the order a reviewer should
understand it. The page helps a human decide whether to trust the change; it is not a
review and it does not hunt for bugs. Be honest: a walkthrough that makes a weak change
look clean is worse than none.

## 1. Find the change

- Argument is a PR number: `gh pr view <n> --json title,body,baseRefName,headRefName,url`
  and `gh pr diff <n>`.
- Argument is a branch or range: diff against the merge-base (`git diff <base>...<head>`).
- No argument: the current branch's open PR if one exists, else `git diff main...HEAD`
  plus uncommitted changes.
- Also read the commit messages, the PR body, and any linked ticket you can reach.

Read every changed file in full where the hunk alone does not show what it does. Read the
callers of each changed exported function. You must understand the change before you
explain it; do not narrate a diff you have not read.

## 2. Work out the story

Decide, from the code, not from the PR body alone:

- **Intent** — what problem the change solves, in two or three plain sentences.
- **Core change** — the one to three hunks that carry the behaviour. Everything else is
  support (wiring, types, renames, tests, docs, generated files).
- **Reasoning** — why each key decision was made, and the alternative it beat. Take it
  from the PR body, commits or code comments. Do not invent a reason: group decisions
  with no written reason under one "Reason not stated" line.
- **Assumptions** — premises the change rests on that the diff does not prove: caller
  behaviour, data shape, external service behaviour, user intent. Mark each as
  *confirmed* (cite where) or *unconfirmed*.
- **Behaviour before/after** — for each user- or system-visible effect, what happened
  before and what happens now.
- **Claims vs evidence** — for each claim the PR makes, the test that proves it
  (file:line), or "no test".
- **Red flags** — removed guards, checks or validation; deleted or weakened tests;
  broadened permissions; new dependencies; migrations; catch-all error handling; changes
  outside the stated scope. List each with file:line. Say "none found" if none.

## 3. Write the page

One HTML file, self-contained except for Mermaid from a CDN
(`https://cdn.jsdelivr.net/npm/mermaid@11/dist/mermaid.esm.min.mjs`). Inline all CSS.
Support light and dark (`prefers-color-scheme`). Readable at laptop width. No frameworks.

Sections, in this order:

1. **Header** — title, branch/PR link, ticket, size (files, +/−), one-paragraph intent.
2. **Verdict strip** — three to five short lines: what to look at first, how much is
   support code safe to skim, the count of red flags and unconfirmed assumptions.
3. **Reasoning and assumptions** — two lists. Unconfirmed assumptions stand out visually.
4. **Change map** — a Mermaid flowchart of the touched modules and how they connect.
   Colour nodes added / changed / removed; untouched neighbours in grey only where they
   explain a connection. Leave out tests, docs and generated files. Keep it under ~15
   nodes; group the rest.
5. **Behaviour** — a before/after table. Add a Mermaid sequence diagram only when the
   control flow between components changed.
6. **Tour** — numbered steps, core change first, then support in dependency order. Each
   step: a heading that says what the hunk does, two to four sentences of why, a
   *read* or *skim* tag, and the relevant hunk rendered as a diff (escape HTML; colour
   added and removed lines; show file:line). Collapse skim steps by default
   (`<details>`). Do not dump the whole diff: show the lines that carry the point, and
   list the remaining files of the step by path.
7. **Claims vs evidence** — table: claim, test (file:line) or "no test".
8. **Red flags** — list, or "none found".
9. **What to check** — at most five concrete questions only a human can answer (product
   intent, naming, a trade-off), each pointing at a tour step.

Writing rules:

- Plain, short sentences. Explain why, not what the code already says.
- Every claim about the code cites file:line, using the head line number (base number for
  deleted lines). Anything you could not confirm says so.
- Use the same names as the code; do not rename concepts to make them sound nicer.
- Do not praise the change. Do not pad.

## 4. Deliver

Write the file to `./tmp/walkthrough/<branch-or-pr>.html` at the top of the working tree
(create the folder; it should be gitignored — warn if it is not). Try to open it
(`wslview`, `xdg-open`, `open`, or on WSL `explorer.exe "$(wslpath -w <file>)"`, whichever
exists); if none works, print the path.

Reply with the path and the verdict strip only. The page holds the detail.
