#!/bin/bash
# Session start hook: display project context when a conversation begins

CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "unknown")
UNCOMMITTED=$(git status --short 2>/dev/null | wc -l | tr -d ' ')

cat << EOF

PROJECT CONTEXT
Branch: $CURRENT_BRANCH
Uncommitted files: $UNCOMMITTED

Remember to check .claude/guidances/ before modifying critical code.

EOF

exit 0
