---
name: activity-summary
description: Use to summarize recent repo activity, check project status, see what's changed, or get a progress update. Triggers on "what's been happening", "activity summary", "project status".
---

# Activity Summary

Quick snapshot of what's happening in the repo. Useful for standups, onboarding, or catching up after time away.

## Process

1. **Recent commits.** `git log --oneline --since="1 week ago"` (adjust timeframe as needed).
2. **Active branches.** `git branch -a --sort=-committerdate | head -10` to see what's being worked on.
3. **Open PRs.** `gh pr list --state open` if GitHub CLI is available.
4. **Open issues.** `gh issue list --state open --limit 10` for context on planned work.
5. **Uncommitted work.** `git status --short` to catch anything in progress.
6. **CI health.** Check recent workflow runs if CI is configured.

## Report Format

Summarize as:
- **This week**: N commits across M branches. Key changes: [brief list]
- **In progress**: [branches with recent activity, open PRs]
- **Open issues**: [top priorities]
- **Uncommitted**: [any local changes]

## Rules

- Keep the summary concise. This is a status check, not a book report.
- Highlight anything surprising (stale PRs, failed CI, unusually large changes).
- If asked about a specific timeframe, adjust the git log range accordingly.
