---
name: deploy
description: Use when ready to push to production. Runs build check, creates PR from dev to main, and merges.
---

# Deploy

Ship to production. Run this after review-and-ship has created a PR, or when you're ready to merge dev into main.

## Process

1. **Verify the branch is clean.** No uncommitted changes, all tests passing.
2. **Run the build.** Full production build. If it fails, stop here.
3. **Create or update the PR.** From your feature branch (or dev) to main.
4. **Use squash merge.** With a conventional commit title so release tooling picks it up.
5. **Verify deployment.** Check that the deploy succeeded (CI, hosting dashboard, or live URL).

## Example

```bash
# Verify clean state
git status
npm run build

# Create PR with squash merge
gh pr create --title "feat(scope): description" --body "Summary of changes"
gh pr merge --squash --admin

# Or if PR already exists
gh pr merge <number> --squash --admin
```

## Rules

- Never push directly to main. Always go through a PR.
- Squash merge with a conventional commit title (feat, fix, chore, etc.)
- Verify the build passes before merging. Don't merge broken code.
- Check deployment health after merge. Don't assume it worked.
