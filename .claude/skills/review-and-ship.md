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

## Built-In Code Review (Recommended)

Yes, we build code review into the workflow — even for solo developers.

You don't need a teammate to review your code. The `pr-review-toolkit` plugin gives you an AI code reviewer that runs as a separate agent with fresh eyes on your changes. It checks for bugs, logic errors, security vulnerabilities, style issues, and adherence to your project conventions. It catches things self-review misses because it doesn't share your assumptions about the code.

This isn't a process bottleneck. It's the reviewer you don't have to wait for. It runs in seconds, doesn't have opinions about your variable naming preferences, and finds the actual bugs.

```
claude install-plugin pr-review-toolkit
```

For teams: the code-reviewer agent gives every PR a consistent baseline review before human reviewers see it. Less nitpicking in PR comments, more focus on design and architecture.

## Rules

- Never push to main directly. Always use a feature branch.
- Commit messages describe *why*, not *what*. The diff shows what.
- If the build or tests fail, fix them before shipping. Don't push broken code.
- One PR per feature or fix. Don't bundle unrelated changes.
