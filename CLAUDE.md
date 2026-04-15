# CLAUDE.md

## Project Overview
<!-- Describe what your project does, its tech stack, and current phase -->
<!-- Example: "A Next.js SaaS that helps teams manage project timelines. Currently in MVP phase." -->

## Development Commands

```bash
# npm run dev        # Start dev server
# npm run build      # Production build
# npm run test       # Run tests
# npm run lint       # Lint code
```

<!-- Uncomment and update the commands above for your project -->

## Critical Rules

<!-- Rules that MUST be followed. Add your own: -->

<!-- - Always sanitize user input before database queries -->
<!-- - Never expose API keys or secrets client-side -->
<!-- - Run tests before committing changes to auth or payment code -->
<!-- - Use parameterized queries, never string concatenation -->

## Common Gotchas

<!-- Bugs and patterns that keep biting. Add yours as you find them: -->

<!-- 1. Auth tokens expire after 1 hour — refresh before long operations -->
<!-- 2. The ORM doesn't auto-migrate — run migrations manually after schema changes -->
<!-- 3. Environment variable changes require a server restart -->
<!-- 4. The test database resets between runs — don't rely on seeded data -->

## Architecture Links

<!-- Pointers to deeper documentation: -->

<!-- - API docs: docs/api/ -->
<!-- - Database schema: docs/schema.md -->
<!-- - Deployment: docs/deploy.md -->
<!-- - Domain guidances: .claude/guidances/ (loaded automatically by hooks) -->
