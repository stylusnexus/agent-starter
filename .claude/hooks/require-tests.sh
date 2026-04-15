#!/bin/bash
# Stop hook: warn if critical files were modified but tests weren't run.
# Customize the CRITICAL_PATTERNS to match your project's sensitive paths.

INPUT=$(cat)

TRANSCRIPT=$(echo "$INPUT" | python3 -c "import json,sys; print(json.load(sys.stdin).get('transcript',''))" 2>/dev/null || echo "")

if [ -z "$TRANSCRIPT" ]; then
    TRANSCRIPT_PATH=$(echo "$INPUT" | python3 -c "import json,sys; print(json.load(sys.stdin).get('transcript_path',''))" 2>/dev/null || echo "")
    if [ -n "$TRANSCRIPT_PATH" ] && [ -f "$TRANSCRIPT_PATH" ]; then
        TRANSCRIPT=$(cat "$TRANSCRIPT_PATH" 2>/dev/null || echo "")
    fi
fi

# Check if code files were modified
if ! echo "$TRANSCRIPT" | grep -qE "(Edit|Write|MultiEdit).*\.(ts|tsx|js|jsx|py|go|rs)"; then
    exit 0
fi

# Customize these patterns for your critical paths
CRITICAL_PATTERNS="(auth|middleware|security|database|migration)"

if ! echo "$TRANSCRIPT" | grep -qE "$CRITICAL_PATTERNS.*\.(ts|tsx|js|jsx|py|go|rs)"; then
    exit 0
fi

# Critical files modified — check if tests were run
if echo "$TRANSCRIPT" | grep -qE "(npm test|npm run test|vitest|jest|pytest|go test|cargo test)"; then
    exit 0
fi

# Tests not run — show warning
echo "Warning: You modified critical code but didn't run tests. Consider running your test suite before finishing."
exit 0
