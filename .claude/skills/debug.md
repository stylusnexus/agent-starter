---
name: debug
description: Use when encountering any bug, test failure, or unexpected behavior. Diagnose before proposing fixes.
---

# Systematic Debugging

Diagnose first, fix second. Never guess at solutions without understanding the cause.

## Process

1. **Reproduce the bug.** Run the failing command or test. Read the full error output.
2. **Read the error message.** Actually read it. Most errors tell you exactly what's wrong.
3. **Trace the execution path.** Follow the code from input to error. Where does it diverge from expected behavior?
4. **Form a hypothesis.** Based on what you've read (not guessed), what's the most likely cause?
5. **Verify the hypothesis.** Add a log, check a value, read a related test. Confirm before fixing.
6. **Fix the root cause.** Not the symptom. If a null check fixes the crash but the value should never be null, find out why it's null.
7. **Verify the fix.** Run the original failing command. Does it pass now? Did you break anything else?

## Rules

- Read the error before searching for solutions
- One fix at a time. Don't change three things and hope one works.
- If the first fix doesn't work, revert it before trying the next approach
- Don't add defensive code to mask bugs. Fix the underlying issue.
- If you're stuck after 3 attempts, escalate. Describe what you've tried and what you've learned.
