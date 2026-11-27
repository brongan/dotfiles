---
name: commit-messages
description: >-
  Formats commit messages and PR or CL descriptions. Use when writing or
  revising one.
---

# Commit messages

Make each message stand alone. Readers see only the message.

- Line 1: `<area>: <imperative sentence>` under 50 characters, written as an order to the codebase.
- Paragraph 1: up to 4 imperative sentences that describe the changes at a high level, not a list of files or edits.
- Paragraph 2: up to 4 sentences on why this change is being made (for example, context about the problem being solved or decisions the code does not show).
- Write each paragraph on one line, with no labels or Markdown. Use straight quotes and apostrophes.
- No references to other commits, PRs, stacks, or people. Plain prose, active voice.
- For a jj commit, write the message from `jj diff -r <rev>` and replace the current description, because the description can be from an earlier version of the commit.
- Set it with one plain `jj describe -r <rev>` command, with one `-m "<part>"` for each part, because the Codex rules allow a command that starts with `jj`, and the Codex sandbox cannot write to the repo.
