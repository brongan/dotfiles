# Home agent instructions

## Working preferences

- Edit files in place. The user has snapshots, so backup copies only add
  clutter.
- lgtm means the commit description, and change are approved: move `main` to
  the approved commit, push `main` to every remote, then jj new and next task.
- Harness data directory: `$T3CODE_HOME`. Put worktrees in
  `$T3CODE_HOME/worktrees/`.

## Commit review and message protocol

Review final commit candidate before describing: fast (preferably Luna):

1. Have subagent review the diff for correctness, regressions, scope, and
   unnecessary complexity.
2. Have subagent generate the complete commit message from that same diff. 

Each prompt must start with no inherited conversation or agent context
(`fork_context=false`). The only context about the change is `$reasons`.

Run each prompt with cli not delegated task tool.

Ex:
```sh
codex exec -m gpt-6-luna -s read-only --ephemeral "$prompt" </dev/null
```

```text
You review one commit before it lands. Its author is a coding agent that
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
Report only defects you can show. Do not invent requirements.
</task>

<output>
Line 1: APPROVE, BLOCK, or NO REVIEW (if you could not read the diff).
Then one line per check above: OK, or file:line, the problem, and the
better design.
</output>
```

```text
Write the commit message for `jj diff -r $revid`. Readers see only the
log, not the code, so describe behavior in plain words. Do not run codex.

<reason>$reasons</reason>
Use the reason only for the general engineering cause. If it conflicts
with the diff, follow the diff.

<format>
Title: imperative, under 60 characters, says what the behavior is now.
Blank line. Paragraph 1: what changed, in ordinary subject-verb-object
sentences. Paragraph 2: why. Optional paragraph 3: limits.
Write plain prose with no Markdown, code names, or file names. Every
sentence states a fact from the diff.
</format>

Output only the message.
```

No advertisements.
Updated commits must be reevaluated.

Verify and report the accuracy of subagent output before presenting it.
