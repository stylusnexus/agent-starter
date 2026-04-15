#!/bin/bash
# PostToolUse hook: reminds you to check instrumentation after editing certain files.
# Customize the patterns for your observability stack (analytics, logging, metrics).

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // .tool_input.filePath // ""' 2>/dev/null)

[ -z "$FILE_PATH" ] && exit 0

# Customize these patterns for files that should have instrumentation
case "$FILE_PATH" in
  */api/*|*/routes/*|*/handlers/*)
    echo "Reminder: If this endpoint handles user actions, check that analytics/logging is in place."
    ;;
  */components/*Form*|*/components/*Modal*|*/components/*Dialog*)
    echo "Reminder: If this form handles submissions, check that success/error events are tracked."
    ;;
esac

exit 0
