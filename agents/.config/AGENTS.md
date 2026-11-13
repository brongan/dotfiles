# Global agent instructions

Not on a Google machine: read ~/.config/agents/home.md.

## Working preferences

- Ask questions in your reply, not with a question tool (request_user_input,
  request_user_input_async).
- Questions are read-only
- "ok" and "kk" mean go do
- Follow instructions and dictated prompts exactly, except typos.
- respond in asd-ste100
- Banned: "x, so y". It is a Claude-ish text pattern.
- Use jj, never git. If git is required, run it inside the repo, never git -C.
- In an unmerged stack, fix a line in the commit that added it.
- If another agent edits the repo, work in your own worktree.
- Clone only with approval, into `~/ws/`, so checkouts stay in one place.
- Edit files in place. The user has snapshots, so backup copies only add
  clutter.
- Pass `--limit 1000` to `gh` list and search commands, because they return 30
  results by default and drop the rest without warning.
- If you are Claude, pass new prose through a subagent on a fast, non-Claude
  model with "translate this claudeish to english".
- End a report after the result. The user knows how to approve.
- Put designs, proposals, and reports inline in chat, never in artifacts. End
  a reply with at most one request for the user, with enough context to answer
  it alone, because the user works in many chats at once.
- Before you state a fact, cause, or number, confirm it with a command, file,
  test, or a subagent on a fast model. Report only confirmed points, because
  the user acts on what you say.
- Before you propose options, test each point that decides between them.
  Untested options waste the user's decision.
- Fix the cause of a defect, not only the one instance.
- Before you propose new code, look for an existing setting or service, and
  give the simplest option first. Less code is less to maintain.
- Before you propose a change to agent instructions, check it against
  Anthropic's prompting best practices: say when it applies, what to
  do, and why. The user should not have to ask for this.

## Delegation

- Give a subagent the task and the user's decisions only, because extra steps
  anchor it on a wrong design.

## Implementation iteration strategy

1. Agree on the design and exact scope before implementation.
2. Implement the smallest meaningfully reviewable diff. Do not include unrelated changes.
3. During iteration, run focused tests and checks. Run the project's full
   precommit checks once the diff is ready for review. Reread the exact final diff
   and check that every changed line contributes to the requested behavior.
4. Run the commit review and message protocol against the exact candidate
   revision.
5. Treat self-review findings as advisory: evaluate them against the project's
   design and test preferences, and fix the legitimate ones. Iterate against a
   zero-context reviewer until none remain. Report the final diff and checks,
   not the findings, because step 1 already settled the design with the user.
6. Do not claim readiness until the final diff, checks, review,
   and commit description all match one another.

## Implementation preferences

Repository style overrides these.

- Edit files with the harness's edit tool, not `sed` or other shell rewrites,
  because a regex replace can corrupt a file without anyone noticing.
- Prefer behavior-preserving, incremental refactors over broad rewrites.
- Keep production behavior changes and test movement separate when practical.
- Do not leave duplicate implementations behind. When splitting code into
  modules, wire in the new modules and remove the old copy.
- Prefer typed wire models over json slop
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
- Avoid cloning as a shortcut.
- The schema file is the source of truth. Once a change is on main, apply it
  to live databases with hand-written DDL kept out of the repo.
