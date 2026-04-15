---
name: orient
description: Use after /clear or at the start of a new session to rebuild working context. Reads key files and reconstructs what you need to know.
---

# Orient

Rebuild your working context fast. Use this when starting a new session, after /clear, or when you've lost track of where things stand.

## Process

1. **Read CLAUDE.md** for project rules and conventions.
2. **Check git status.** What branch are you on? Any uncommitted work?
3. **Read recent commits.** `git log --oneline -10` to see what's been happening.
4. **Check for active plans.** Look in `docs/plans/` or `docs/specs/` for in-progress work.
5. **Scan open tasks.** Any TODO lists or task tracking from a prior session?
6. **Report back.** Summarize: current branch, recent work, what seems in-progress, and any uncommitted changes.

## Rules

- Don't make assumptions about project state. Read the files.
- If you find uncommitted work, mention it. Don't just start new work on top of it.
- Keep the summary brief. The goal is context, not a book report.
