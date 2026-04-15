---
name: verify
description: Use before claiming work is complete, fixed, or passing. Run verification commands and confirm output before reporting done.
---

# Verification Before Completion

Don't say "it works" without proving it. Run the commands. Read the output. Confirm success.

## Process

1. **Run the build.** Does it compile without errors?
2. **Run the tests.** Do they pass? All of them, not just the new ones.
3. **Run the linter.** Any new warnings or errors?
4. **Check the diff.** Does `git diff` show only the changes you intended? No accidental files?
5. **Test the feature.** If it's UI, open it in a browser. If it's an API, call it. Don't skip this.

## Rules

- Never report "done" based on assumptions. Run the actual command.
- If a check fails, fix it before reporting. Don't report "done with caveats."
- Screenshot or paste output as evidence when relevant.
- If you can't verify (no test suite, no dev server), say so explicitly rather than claiming success.
