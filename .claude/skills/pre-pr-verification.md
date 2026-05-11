---
name: pre-pr-verification
description: Use when adding or modifying API route files, writing test mocks for database calls, or about to open a PR after `npm run dev` worked but you haven't run the strict production build yet.
---

# Pre-PR Verification

Local development bundlers are permissive on purpose. They optimize for iteration speed, not strictness. The build that ships to users is stricter, and the gap between "dev works" and "production builds" is where weekend incidents come from. Close the gap on your machine, not in CI.

## Process

1. **Run the production build, not just dev.** `npm run build` (or your framework's equivalent strict build). Catches type errors, missing imports, framework-specific structural rules, and config drift that `dev` mode skips.
2. **For new route files in file-based routing: check sibling slug directories.** Two siblings with conflicting slug shapes (`[id]` next to `[slug]`, or a static name next to a dynamic one with overlapping coverage) compile fine in permissive dev and throw at strict build time. `ls` the parent directory before opening the PR.
3. **For database mocks: validate the row payload against schema invariants.** A mock returning `{ data: { id: '...' }, error: null }` passes any test that doesn't inspect what's in `data`. The production insert may require a NOT NULL column the mock never populates. Schema-aware mocks return rows that match the actual table shape.
4. **For env-sensitive code: integration test against a local Docker stack, not production.** Production credentials in tests are how you discover you wiped the customer table at 2am. Use a disposable local stack with seedable data.

## Example

```bash
# Before opening a PR that adds a route
ls src/app/api/users/     # look for sibling [bracket] dirs that may conflict
npm run build             # full strict build, not `npm run dev`
```

```typescript
// Schema-aware mock: every NOT NULL column populated
const mockUserRow = {
  id: 'uuid-here',
  email: 'test@example.com',
  user_id: 'auth-uuid',           // NOT NULL in real schema, MUST be present
  created_at: new Date().toISOString(),
  // ...every other NOT NULL column on this table
};

// Blanket-pass mocks are the dangerous default
// const badMock = { data: {}, error: null };  // passes test, crashes prod
```

```bash
# Integration tests use local Supabase, not production
eval "$(npx supabase status -o env)"
NEXT_PUBLIC_SUPABASE_URL=... npx vitest run
```

## Rules

- **If your test passes but the production build fails, your test is lying.** Fix the test, not the build.
- **Never run integration tests against production credentials.** Local Docker stack, always. Even "read-only" tests can hit rate limits, trigger billing webhooks, or pollute analytics.
- **Permissive dev is necessary but not sufficient.** A passing `npm run dev` is the floor, not the ceiling. Strict build is the contract with CI.
- **Don't claim "build passes" without showing the output.** Paste the success line. Past selves have lied about this.
- **The cost of one extra `npm run build` before a PR is thirty seconds. The cost of finding out at 5pm on Friday is a weekend.**
