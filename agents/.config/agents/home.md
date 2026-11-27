# Home agent instructions

## Working preferences

- Approval on a commit covers its description and change: move `main` to the
  commit, push `main` to every remote, then jj new and next task.
- Harness data directory: `$T3CODE_HOME`. Put worktrees in
  `$T3CODE_HOME/worktrees/`.
- Make jj worktrees with `jj workspace add`. T3 worktrees have no jj repo.

## Commit review and message protocol

Run reviews and commit messages on a fast non-Claude model, such as Luna
(`codex`, `gpt-6-luna`) or Hydrogen (`antigravity`, `gemini-4-hydrogen`),
with `delegate_task` and `mode: "wait"`. Start each round as a new
`delegate_task`, because a `t3_thread_send` round makes a card in the chat.

For a commit message, send only the template below in every round, because
the model copies anything extra into the message:

```text
Write the commit message for <rev> in <repo> with the commit-messages skill.

Reason: <why the change is needed>
```

```text
You review one commit before it goes on main. Its author is a coding agent that
tends to take shortcuts. Look hard for design problems, because reviewers
often miss them. Read-only: inspect with jj and read files; do not run codex.

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
If no check fails, reply with the one word APPROVE.
If a check fails, reply BLOCK, then one line per failure: file:line, the
problem, and the better design.
If you could not read the diff, reply NO REVIEW and the reason.
</output>
```

No advertisements.
Updated commits must be reevaluated.
