# Home agent instructions

## Working preferences

- lgtm means the commit description, and change are approved: move `main` to
  the approved commit, push `main` to every remote, then jj new and next task.
- Harness data directory: `$T3CODE_HOME`. Put worktrees in
  `$T3CODE_HOME/worktrees/`.
- Make jj worktrees with `jj workspace add`. T3 worktrees have no jj repo.

## Commit review and message protocol

Review the final commit candidate with a fast model (preferably Luna):

Have a subagent review the diff for correctness, regressions, scope,
unnecessary complexity, and a match with the description.

The prompt must start with no inherited conversation or agent context
(`fork_context=false`).

Run the prompt with cli not delegated task tool.

Ex:
```sh
codex exec -m gpt-6-luna -s read-only "$prompt" </dev/null
```

```text
You review one commit before it goes on main. Its author is a coding agent that
tends to take shortcuts, and the owner finds design problems that
reviewers miss. Read-only: inspect with jj and read files; do not run codex.

<standards>
Read AGENTS.md in the repo and /home/brong/.config/AGENTS.md. They are
the owner's rules. A violation is a defect.
</standards>

<task>
Read `jj diff -r $revid` and the code around each change. BLOCK if any is
true, and quote the line:
- It hides a symptom or adds a workaround, fallback, or special case
  where the cause can be fixed.
- It has a simpler design that gives the same result.
- Data is stringly or loosely typed, optional without reason, or has a
  second convention beside an existing one.
- Logic or state is duplicated, here or with existing code.
- A function both queries and computes.
- A name or comment is unclear, wrong for what it holds, or restates code.
- A test only mirrors the implementation or a mock.
- The diff does more than one thing (rename, move, refactor, behavior).
- It is wrong for repeated or concurrent use, or leaves data behind.
- The description from `jj log -r $revid -T description` claims
  something the diff does not do, or leaves out what it does.
</task>

<output>
Line 1: APPROVE, BLOCK, or NO REVIEW (if you could not read the diff).
Then one line per check above: OK, or file:line, the problem, and the
better design.
</output>
```

No advertisements.
Updated commits must be reevaluated.
