#!/bin/bash
# Injects relevant guidance when you touch domain-specific files.
# Customize the case patterns below to match your project structure.

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // .tool_input.filePath // ""' 2>/dev/null)

[ -z "$FILE_PATH" ] && exit 0

GUIDANCE=""
case "$FILE_PATH" in
  */ai/*|*/prompts/*|*/llm/*)      GUIDANCE="ai-safety" ;;
  */test*|*/__tests__/*)           GUIDANCE="testing-strategy" ;;
  */db/*|*/migrations/*|*/schema*) GUIDANCE="database-patterns" ;;
  # Add your own patterns here:
  # */auth/*|*/middleware/*)        GUIDANCE="auth-security" ;;
  # */components/ui/*)             GUIDANCE="design-system" ;;
esac

if [ -n "$GUIDANCE" ] && [ -f ".claude/guidances/${GUIDANCE}.md" ]; then
  echo "CONTEXT: Read .claude/guidances/${GUIDANCE}.md before making changes."
fi
