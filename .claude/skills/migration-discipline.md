---
name: migration-discipline
description: Use when adding or modifying a Supabase or Postgres migration, before running `supabase db push`, or when production hits a "function not found" or "table does not exist" error after a deploy.
---

# Migration Discipline

A migration that runs once on your laptop and once in CI is not the same as a migration that survives years of replays, partial failures, and team rebases. Write every migration as if it's about to be applied to a database it's already been applied to.

## Process

1. **Make it idempotent.** `CREATE TABLE IF NOT EXISTS`, `DROP POLICY IF EXISTS ... ; CREATE POLICY ...`, `CREATE OR REPLACE FUNCTION`, `ALTER TABLE ... ADD COLUMN IF NOT EXISTS`. A migration that errors on second run is a migration that will fail in CI rebases and on every fresh clone.
2. **Use second-precision timestamps in filenames.** `YYYYMMDDHHmmss_description.sql`. Minute-precision filenames collide during fast iteration and Supabase silently picks one.
3. **`SET search_path = public` on every function you define.** Without it, a privileged caller can manipulate `search_path` and your function resolves to attacker-controlled schemas. Security-definer functions without `search_path` are an audit finding waiting to happen.
4. **Never use `NOW()` or `CURRENT_TIMESTAMP` in an index predicate.** They aren't `IMMUTABLE`. Postgres will accept the migration and reject the index at apply time, which is worst-of-both-worlds.
5. **Enable RLS on every table that holds user data.** `ALTER TABLE foo ENABLE ROW LEVEL SECURITY;`. A table with no RLS and no policies is a public table, regardless of how the API in front of it behaves.
6. **Verify the migration applied with `supabase migration list`, not the exit code.** `supabase db push` can return success without applying. The migration list shows two timestamp columns: local and remote. Both populated means the migration is live. One empty means it isn't.

## Example

```sql
-- 20260510120000_add_user_settings.sql

CREATE TABLE IF NOT EXISTS public.user_settings (
  user_id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  theme TEXT NOT NULL DEFAULT 'system',
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

ALTER TABLE public.user_settings ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Users read own settings" ON public.user_settings;
CREATE POLICY "Users read own settings" ON public.user_settings
  FOR SELECT USING (auth.uid() = user_id);

CREATE OR REPLACE FUNCTION public.touch_user_settings()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public  -- mandatory
AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$;
```

After pushing, verify both columns are populated:

```bash
npx supabase db push
npx supabase migration list 2>&1 | tail -5
# Look for: 20260510120000  |  20260510120000  (both timestamps present)
```

## Rules

- **One canonical migrations directory.** Whatever Supabase reads from (typically `supabase/migrations/`) is the only one that exists. Legacy migration directories are landmines that ship broken state without warning.
- **Never edit a migration after it's been applied to production.** Write a new one. Editing an applied migration breaks every fresh checkout and every CI run.
- **Verify M2M schemas with `psql \d <table>` before writing dependent specs.** Six rounds of agent code review will not catch a wrong column assumption. Only a query will. Treat schema dumps as canonical context, not the spec's stated assumptions.
- **Schema-aware test mocks beat blanket `{ error: null }`.** A NOT NULL column omitted from a mocked insert passes the test and crashes production. Validate mock payloads against the actual table shape.
- **Don't trust `supabase db push` exit code alone.** Success can hide a no-op. Always re-list and check both timestamp columns.
