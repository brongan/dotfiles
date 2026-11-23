# Global agent instructions

Not on a Google machine: read ~/.config/agents/home.md first.

## Working preferences

- Ask questions in your reply, not with a question tool (request_user_input,
  request_user_input_async).
- Questions are read-only
- "ok" and "kk" mean go do
- Follow instructions and dictated prompts exactly, except typos.
- respond in asd-ste100
- Banned: "x, so y". It is a Claude-ish text pattern.
- Use Mermaid or HTML for diagrams and tables, not ASCII art or markdown
  tables. T3 Code and Jetski render both.
- Use jj, never git. If git is required, run it inside the repo, never git -C.
- In an unmerged stack, fix a line in the commit that added it.
- If another agent edits the repo, work in your own worktree.
- Clone only with approval, into `~/ws/`, so checkouts stay in one place.
- Edit files in place. Filesystem snapshots keep old versions, and backup
  copies only add clutter.
- Pass `--limit 1000` to `gh` list and search commands, because they return 30
  results by default and drop the rest without warning.
- If you are Claude, have a non-Claude subagent write and set commit messages,
  PR descriptions, and code comments (`jj describe -r <rev> -m` or the PR
  update command), passing only the repo, revision, and reason for the change,
  because Claude speaks claudeish, not English, and extra notes get copied
  into the message.
- End a report after the result. Do not explain how to approve.
- Put designs, proposals, and reports inline in chat, never in artifacts. End
  a reply with at most one request, with enough context to answer it alone,
  because many chats run at once.
- Before you state a fact, cause, or number, confirm it with a command, file,
  test, or a subagent on a fast model. Report only confirmed points, because
  each report decides the next action.
- Before you propose options, test each point that decides between them.
  Untested options lead to a wrong choice.
- Fix the cause of a defect, not only the one instance.
- Before you propose new code, look for an existing setting or service, and
  give the simplest option first. Less code is less to maintain.
- Before you propose a change to agent instructions, check it against
  Anthropic's prompting best practices: say when it applies, what to
  do, and why. Do this check without a request.

## Delegation

- Give a subagent the task and the agreed decisions only, because extra steps
  anchor it on a wrong design.

## Implementation iteration strategy

1. Agree on the design and exact scope before implementation.
2. Implement the smallest meaningfully reviewable diff. Do not include unrelated changes.
3. During iteration, run focused tests and checks. Run the project's full
   precommit checks once the diff is ready for review. Reread the exact final diff
   and check that every changed line contributes to the requested behavior.
4. Before the reviewer sees the diff, check every line against the
   implementation preferences below and fix what fails. The reviewer misses
   design problems. Its APPROVE does not show that the code is good.
5. Run the commit review and message protocol against the exact candidate
   revision.
6. Treat self-review findings as advisory: evaluate them against the project's
   design and test preferences, and fix the legitimate ones. Iterate against a
   zero-context reviewer until none remain. Report the final diff and checks,
   not the findings, because step 1 already settled the design.

## Implementation preferences

Repository style overrides these.

- Edit files with the harness's edit tool, not `sed` or other shell rewrites,
  because a regex replace can corrupt a file without anyone noticing.
- Keep production behavior changes and test movement separate when practical.
- Prefer typed wire models over json slop
- When you write a parser for binary data, follow these rules, because a
  parser reads untrusted input:
  - Parse, don't validate.
  - Check every length before you read.
  - Read in wire order.
  - Reject, do not repair.
  - Make the parser total.
  - Decode into enums.
  - Write the parser and serializer as a pair.
  - Fuzz the parser.
  - Use a parser library or one shared reader.
- Make invalid states unrepresentable.
- Replace vague errors with specific protocol or system errors. Avoid catch-alls.
- Startup failures should return errors, not panic or silently fall back to
  degraded behavior.
- Write one test per behavior, as idiomatic in the language.
- Write a comment only for the contract or the reason, as a full sentence.
  The code already shows what it does.
- In Rust, put `#[cfg(test)]` tests in a separate file.
- Write unsafe code as a thin unsafe layer around a safe core, because the
  compiler checks only the safe part. No caller can misuse a safe API.
- Prefer iterator pipelines (`map`, `filter`, `filter_map`, `collect`).
- The schema file is the source of truth. Once a change is on main, apply it
  to live databases with hand-written DDL kept out of the repo.
