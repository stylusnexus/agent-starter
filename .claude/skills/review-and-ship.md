---
name: review-and-ship
description: Use when work is done and ready to commit, push, and create a PR. Reviews changes, fixes issues, then ships.
---

# Review and Ship

The last mile before code leaves your machine. Review your own work, fix what you find, then ship it.

## Process

1. **Run the build.** `npm run build` (or equivalent). Fix any errors.
2. **Run tests.** Full suite, not just new tests. Fix any failures.
3. **Run the linter.** Fix any new warnings.
4. **Review the diff.** `git diff` to see all changes. Look for:
   - Debug code left behind (console.log, TODO comments)
   - Unintended file changes (lock files, config drift)
   - Missing test coverage for new code paths
5. **Commit.** Conventional commit format: `type(scope): description`
6. **Push.** Create a feature branch if not already on one.
7. **Create PR.** Include a summary of what changed and why, plus a test plan.

## Deeper Review (Recommended)

The self-review above catches obvious issues, but a dedicated code reviewer catches more. If you have the `pr-review-toolkit` plugin installed, use the `code-reviewer` agent for a thorough review before creating the PR:

```
claude install-plugin pr-review-toolkit
```

The code-reviewer agent checks for bugs, logic errors, security vulnerabilities, style issues, and adherence to project conventions. It runs as a separate subagent with fresh eyes on your changes — it catches things self-review misses because it doesn't share your assumptions about the code.

## Rules

- Never push to main directly. Always use a feature branch.
- Commit messages describe *why*, not *what*. The diff shows what.
- If the build or tests fail, fix them before shipping. Don't push broken code.
- One PR per feature or fix. Don't bundle unrelated changes.
