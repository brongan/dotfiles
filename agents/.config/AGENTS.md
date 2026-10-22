# Global agent instructions

## Working preferences

- Questions are read-only
- "ok" and "kk" mean go do
- respond in asd-ste100
- Use jj, never git.
- End a report after the result. The user knows how to approve.

## Commit review and message protocol

Review final commit candidate before describing: fast (preferably Luna):

1. Have subagent review the diff for correctness, regressions, scope, and
   unnecessary complexity.
2. Have subagent generate the complete commit message from that same diff. 

Each prompt must start with no inherited conversation or agent context
(`fork_context=false`). Do not leak context about the change

Run each prompt with cli not delegated task tool.

Ex:
```sh
codex exec -m gpt-6-luna -s read-only --ephemeral "$prompt"
```

```text
Review `jj diff -r $revid` in the working directory for correctness,
regressions, scope, simplicity, and tests. Do not edit files or commit. Do not
spawn subagents or run codex. Return APPROVE or BLOCK with concise, concrete
findings.
```

```text
Generate a commit message based on https://google.github.io/eng-practices/review/developer/cl-descriptions.html
Run jj diff -r $revid to see the diff 
The change is being made because $reasons
Write plain English: complete sentences, no stacked nouns.
Do not spawn subagents or run codex.
Output only the commit message in plain text with no Markdown.
```

### Commit message format

- Write a short, standalone first line that summarizes the change as an imperative, with no trailing period.
- Follow the first line with a blank line.
- Use the body to explain what changed, then why, in separate paragraphs. Add context, reasons, limitations, and anything future readers need to understand the change.
- Do not enumerate changes

No advertisements.
Updated commits must be reevaluated.

Verify and report the accuracy of subagent output before presenting it.

## Implementation iteration strategy

1. Agree on the design and exact scope before implementation.
2. Create a dedicated change with jj new.
3. Implement the smallest meaningfully reviewable diff. Do not include unrelated changes.
4. During iteration, run focused tests and checks. Run the project's full
   precommit gate once the diff is ready for review. Reread the exact final diff
   and check that every changed line contributes to the requested behavior.
5. Run the fast review and commit-message protocol above against the exact
   candidate revision.
6. Treat review findings as advisory: evaluate them against the project's
   design and test preferences. Iterate against 0 context reviewer until legitimate issues are addresssed.
7. Do not claim readiness until the final diff, checks, review,
   and commit description all match one another.
8. lgtm means the commit description, and change are approved: move `main` to
   the approved commit, push `main` to every remote, then jj new and next task.

## Implementation preferences

- Prefer behavior-preserving, incremental refactors over broad rewrites.
- Keep production behavior changes and test movement separate when practical.
- Do not leave duplicate implementations behind. When splitting code into
  modules, wire in the new modules and remove the old copy.
- Prefer typed wire models over json slop
- Replace vague errors with specific protocol or system errors. Avoid catch-alls.
- Startup failures should return errors, not panic or silently fall back to
  degraded behavior.
- Organize tests by behavior in separate files rather than large inline suites.
- Prefer iterator pipelines (`map`, `filter`, `filter_map`, `collect`).
- Avoid cloning as a shortcut.

