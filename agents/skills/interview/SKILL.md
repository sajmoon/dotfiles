---
name: interview
description: Interview the user to find the real goal behind a request, then produce a spec split into small independent slices. Forces explicit sign-off on every key decision first. Triggers on "interview me", "let's spec this out", "help me figure out what I actually want".
argument-hint: "[rough idea]"
---

# Interview

Turn a vague request into a spec. The spec is the deliverable — it lives in this
conversation unless the user asks for files, or it is big enough to outlive the
session (then offer, don't assume).

Bias to **small compartmentalized slices**: each independently implementable and
independently reviewable, with explicit non-overlapping scope.

## 1. Read first

Before the first question, read the relevant code — structure, existing
patterns, adjacent features, anything the request touches. Never ask what the
repo already answers. Ask sharper questions because you read it.

## 2. Goal

Questions until you can state, in one sentence, the underlying goal — the
problem behind the request, not the solution asked for. Plus: what does "done"
look like, and who is it for?

No solutioning in this phase.

## 3. Forks

**One question at a time.** Never batch. Each question informed by the last
answer. Prefer concrete either/or over open-ended when you can see the options
— easier to answer, sharper signal.

Every time an answer settles a fork — storage, boundaries, sync vs async, error
behaviour, a scope cut, a dependency — append to the **decisions ledger**:

```
decision · chosen · rejected · why
```

Record it even when the user's answer seemed obvious; obvious-to-them is where
things get missed. If you make a call yourself because it's routine, that goes
in the ledger too, marked as your assumption.

Stop when the next question would only be probing nice-to-haves rather than
changing the spec. Say that you're stopping and why.

## 4. Verify

Replay before writing anything:

- the goal, in one sentence
- the full decisions ledger
- the proposed slices, one line each
- anything still unresolved, stated as an explicit assumption

Ask the user to confirm or correct. Corrections loop back to step 3. **Do not
produce the spec until they sign off.**

## 5. Spec

Per slice:

- **Goal** — one sentence
- **Scope** — what it covers
- **Out of scope** — what it explicitly does not, especially anything another
  slice owns
- **Acceptance** — how you know it's done
- **Depends on** — other slices, or nothing

Order slices so each is buildable when its dependencies land. Keep the ledger
attached to the spec; it's the record of why, and it's what makes the spec
reviewable.

Stop here. Implementation is a separate ask.
