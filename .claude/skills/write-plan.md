---
name: write-plan
description: Use when you have a spec or requirements for a multi-step task. Creates a detailed implementation plan before touching code.
---

# Write Implementation Plan

Turn specs into step-by-step plans that any developer (or subagent) can execute without ambiguity.

## Process

1. **Read the spec.** Understand what's being built and why.
2. **Map out files.** List every file that will be created or modified, and what each one is responsible for.
3. **Break into tasks.** Each task should produce self-contained, testable changes. 2-5 minutes per step.
4. **Write exact steps.** Every step has: files to touch, code to write, commands to run, expected output.
5. **No placeholders.** "Add appropriate error handling" is a plan failure. Show the actual code.
6. **Save the plan.** Write to `docs/plans/YYYY-MM-DD-<feature>.md` and commit.

## Task Structure

Each task should follow this pattern:

```
### Task N: [Component Name]

Files:
- Create: exact/path/to/file.ts
- Modify: exact/path/to/existing.ts
- Test: tests/exact/path/to/test.ts

- [ ] Step 1: Write the failing test
- [ ] Step 2: Run test to verify it fails
- [ ] Step 3: Write minimal implementation
- [ ] Step 4: Run test to verify it passes
- [ ] Step 5: Commit
```

## Rules

- Every step that changes code must include the actual code
- Exact file paths always, never "in the appropriate directory"
- DRY, YAGNI, TDD, frequent commits
- Plans are consumed by subagents who have no context beyond what you write
