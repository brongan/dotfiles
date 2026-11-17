---
name: review-comments
description: >-
  Addresses human reviewer comments on CLs and PRs, one comment at a time with
  user approval. Use when changing code in response to reviewer feedback. Don't
  use for self-review.
---

# Review comments

Show one comment at a time with:
1. the comment, quoted, with its author,
2. why the fix is correct, with the rule and its link if one applies,
3. the code and test diff,
4. the proposed reply to the reviewer.

After the user approves, apply, push or upload the fix, and wait for the push
to finish before posting the reply. On GitHub, make one new commit for each
round of human feedback.
