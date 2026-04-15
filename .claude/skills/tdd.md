---
name: tdd
description: Use when implementing any feature or bugfix. Write the failing test first, then make it pass.
---

# Test-Driven Development

Write the test before the code. Every time. No exceptions.

## Process

1. **Write a failing test** that describes the behavior you want.
2. **Run it.** Confirm it fails for the right reason (not a syntax error).
3. **Write the minimum code** to make the test pass. Nothing extra.
4. **Run the test again.** Confirm it passes.
5. **Refactor** if needed, keeping tests green.
6. **Commit.** Small, focused commits after each green test.

## Rules

- Tests describe behavior, not implementation ("returns error when input is empty", not "calls validateInput")
- One assertion per test when possible
- Don't mock your own code. Mock external services.
- If you can't write a test for it, the design needs work
- Run the full relevant test suite before committing, not just the new test
