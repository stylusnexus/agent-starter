---
name: execute-plan
description: Use when you have a written implementation plan to execute. Works through tasks sequentially with review checkpoints.
---

# Execute Implementation Plan

Work through a plan task by task. Don't skip steps. Don't improvise.

## Process

1. **Read the full plan first.** Understand the overall shape before starting.
2. **Work one task at a time.** Mark each step as complete with `[x]` as you go.
3. **Follow TDD within each task.** Test first, implement, verify, commit.
4. **Commit after each task.** Small, focused commits. Don't batch multiple tasks.
5. **Review between tasks.** Does the work so far match the plan? Any drift?
6. **Report blockers immediately.** If a step doesn't work as planned, stop and say so.

## Rules

- Execute what the plan says, not what you think it should say
- If the plan is wrong, flag it. Don't silently deviate.
- Each task should leave the codebase in a working state
- Run tests after every task, not just at the end
- If a task is too large, break it down further before executing
