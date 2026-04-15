# Database Patterns

## When This Guidance Applies

Loaded automatically when editing migration files, schema definitions, or database queries.

## Migrations

- Always idempotent (`IF NOT EXISTS`, `DROP ... IF EXISTS`)
- Never destructive in production without a tested rollback plan
- Test migrations on a copy of production data before applying
- Use second-precision timestamps for migration filenames

## Query Patterns

- Use parameterized queries — never string concatenation
- Add indexes for columns used in WHERE and JOIN clauses
- Use connection pooling in production
- Prefer `SELECT` specific columns over `SELECT *`
- Use `RETURNING` for insert/update operations that need the result

## Security

- Row Level Security (RLS) on all user-facing tables
- Service role keys stay server-side only — never expose to client
- Audit log for sensitive data access and modifications
- Always use `SET search_path = public` on database functions

## Common Gotchas

- Auto-generated type files may include CLI stderr output — check head and tail
- Views not in generated types can cause deep type instantiation errors
- `NOW()` is not immutable — don't use in index predicates
