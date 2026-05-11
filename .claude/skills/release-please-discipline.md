---
name: release-please-discipline
description: Use when configuring release automation, naming feature branches, writing commit messages, or opening PRs that will be squash-merged into main.
---

# Release-Please Discipline

The cost of getting release automation right is a one-time setup. The cost of getting it wrong is shipping versions that don't match what's in the changelog. Get the inputs right and the outputs follow.

## Process

1. **Branch from main with the issue number in the name.** `feat/123-add-passkey-auth`, not `feature-branch-2`. Future-you grepping `git log` will thank you, and the issue number is a one-shot link back to the discussion that justified the work.
2. **Write commits as Conventional Commits.** `feat(scope): description`, `fix(scope): description`, `chore(scope): description`. Scope is optional and kebab-case. Use `!` for breaking changes (`feat!:`).
3. **Make the PR title the actual conventional commit.** With squash-merge, the PR title becomes the single commit message on main. release-please reads that title to decide whether to bump and how. A title like "deploy to production" produces an empty changelog.
4. **Close referenced issues manually after the squash merge.** `Closes #N` in the PR body does NOT fire on squash-merge in every repo we've tested. Use `gh issue close <num> --comment "Shipped in #<pr>." --reason completed` as the last step.
5. **Back-merge main into dev with `--no-ff`.** The squash created a new SHA on main; dev still has the original feature commits with their original SHAs. Without an alignment merge, every future `git log main..dev` re-surfaces the same commits as if they hadn't shipped. The merge has zero content changes, but its alignment commit keeps the ancestry honest.

## Example

```bash
# Branch with issue number
git checkout -b feat/123-passkey-auth main

# After work, PR title carries the conventional commit
gh pr create --base main \
  --title "feat(auth): passkey enrollment and verification"

# After CI passes and merge
gh pr merge <pr-num> --squash --admin

# Manual issue close (Closes #N doesn't fire on squash)
gh issue close 123 --comment "Shipped in #<pr-num>." --reason completed

# Align dev so future deploys don't re-surface phantom diff
git checkout dev
git merge --no-ff origin/main -m "chore: back-merge main after #<pr-num> squash"
git push origin dev
```

## Rules

- **PR title is the release-please input.** Describe what shipped. "Deploy to production" is not a feature description.
- **Pre-1.0: `feat` bumps patch, `feat!` bumps minor.** `BREAKING CHANGE:` in the body is read by some tools but not by release-please's default config. Use `!` to be explicit.
- **One feature per PR.** Bundled PRs make changelogs lie and revert harder than it needs to be.
- **Never commit directly to main or dev.** Always feature branch, always PR, always squash. The discipline is what makes automation possible.
- **If you skip the back-merge once, the next deploy will tell you about it.** A `main..dev` diff full of already-shipped commits means someone forgot. Fix that before opening the next PR.
