# AI Safety Patterns

## When This Guidance Applies

Loaded automatically when editing files in `src/lib/ai/`, `src/lib/prompts/`, or any AI integration code.

## Key Patterns

### Input Sanitization

Always sanitize user input before passing to AI models:
- Strip HTML and script tags
- Enforce length limits (prevent context stuffing)
- Check for prompt injection patterns
- Log raw input for audit before sanitizing

### Output Validation

Always validate AI responses before returning to users:
- Check for unsafe or inappropriate content
- Verify response matches expected schema (parse with Zod or similar)
- Strip any system prompt leakage
- Log all AI interactions for debugging and audit

### Rate Limiting

Protect AI endpoints from abuse:
- Per-user rate limits on generation endpoints
- Cost tracking per request (token usage)
- Circuit breaker for upstream API failures
- Graceful degradation when limits are hit

### Model Configuration

- Use content-type-specific temperature settings (creative content: 0.9, structured output: 0.7)
- Always set max_tokens to prevent runaway costs
- Use JSON mode when you need structured output (with OpenAI; other providers may differ)
