---
name: github-workflow
description: >-
  Creates, checks, and merges GitHub pull requests with the gh CLI. Use when
  opening, updating, or merging a GitHub PR.
---

# GitHub PR workflow

1. **Local CI:** Run the commands from `.github/workflows/ci.yml` on the
   candidate revision before pushing.
2. **Draft:** Once local tests pass, push to the user's fork and open a draft
   PR with `gh pr create --draft`, then report the PR URL. The user decides when
   a PR is ready, so run `gh pr ready` only with explicit approval.
3. **Description:** For a small PR, use the commit message (`gh pr create
   --fill`). For a complex PR, write Markdown that shows the reviewer what the
   change is for: what changed and why, evidence (tables, Mermaid diagrams,
   coverage, test results), and links to each spec or implementation it follows
   or diverges from, with reasons for any divergence. Use short headings and
   code formatting. Don't hard-wrap; GitHub renders each newline. Omit other
   PRs, internal links, and closing boilerplate.
4. **CI:** Before requesting review, run `gh pr checks <n> --watch` and trigger
   unrun checks until all pass.
5. **Merge:** Never press a GitHub merge button for one commit; push that
   commit to `main` yourself, because GitHub rewrites it. For several
   commits, run `gh pr merge --merge`. If the repo requires linear
   history, push the commits to `main` yourself.
