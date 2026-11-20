# Home agent instructions

## Working preferences

- Approval on a commit covers its description and change: move `main` to the
  commit, push `main` to every remote, then jj new and next task.
- Harness data directory: `$T3CODE_HOME`. Put worktrees in
  `$T3CODE_HOME/worktrees/`.
- Make jj worktrees with `jj workspace add`. T3 worktrees have no jj repo.

## Commit review and message protocol

Review the final commit candidate with a fast model (preferably Luna):

For reviews and translations, use `delegate_task` with `mode: "wait"` to run
Luna (`codex`, `gpt-6-luna`). Start each round, feedback included, as a new
`delegate_task` with the earlier output and your evidence, because T3 shows
the result of a `t3_thread_send` round as a card in the chat.

When Luna sets a commit message, tell it to run one plain command:
`jj describe -r <rev> -m "<line 1>" -m "<paragraph 1>" -m "<paragraph 2>"`,
with a backslash before each `"` in the message. The Codex sandbox mounts
`.git` read-only, and only a command that starts with `jj` matches the rule
that runs it outside the sandbox.

When you ask Luna for a commit message, give it the facts about why the change
is made, in plain words, because the message must be in Luna's words, not
Claude's.

```text
You review one commit before it goes on main. Its author is a coding agent that
tends to take shortcuts, and the owner finds design problems that
reviewers miss. Read-only: inspect with jj and read files; do not run codex.

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
