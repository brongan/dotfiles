# Global agent instructions

Not on a Google machine: read ~/.config/agents/home.md.

## Working preferences

- Ask questions in your reply, not with a question tool (request_user_input,
  request_user_input_async).
- Questions are read-only
- "ok" and "kk" mean go do
- respond in asd-ste100
- Use jj, never git. If git is required, run it inside the repo, never git -C.
- Pass `-r $revid` explicitly. Never reference `@`.
- Edit a revision in a child from `jj new -r $revid`. Never `jj edit`. Squash
  only after approval.
- Give each parallel agent its own worktree in the harness data directory,
  never in a shared working copy or `~/ws/`.
- End a report after the result. The user knows how to approve.
- Put designs, proposals, and reports inline in chat, never in artifacts. Put
  requests for the user in a list at the end.
- Before you state a fact, confirm it with a command, file, or test. The user
  acts on what you say.
- Before you propose options, test each point that decides between them.
  Untested options waste the user's decision.
- Before you propose new code, look for an existing setting or service, and
  give the simplest option first. Less code is less to maintain.
- Before you propose a change to agent instructions, check it against
  Anthropic's prompting best practices: say when the rule applies, what to
  do, and why. The user should not have to ask for this.

## Delegation

- Include the user’s agreed scope and approvals in each subagent prompt.

## Implementation iteration strategy

1. Agree on the design and exact scope before implementation.
2. Create a dedicated change with jj new.
3. Implement the smallest meaningfully reviewable diff. Do not include unrelated changes.
4. During iteration, run focused tests and checks. Run the project's full
   precommit gate once the diff is ready for review. Reread the exact final diff
   and check that every changed line contributes to the requested behavior.
5. Run the commit review and message protocol against the exact candidate
   revision.
6. Treat review findings as advisory: evaluate them against the project's
   design and test preferences. Iterate against 0 context reviewer until legitimate issues are addresssed.
   Give findings that change user-visible behavior to the user with options
   before you change the code. That behavior is the user's decision.
7. Do not claim readiness until the final diff, checks, review,
   and commit description all match one another.

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
- The schema file is the source of truth. Once a change lands on main, apply it
  to live databases with hand-written DDL kept out of the repo.
