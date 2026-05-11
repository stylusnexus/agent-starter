---
name: tier-and-billing-patterns
description: Use when implementing subscription tiers, gating features by plan, integrating Stripe webhooks, designing trial behavior, or making AI calls whose model depends on the user's plan.
---

# Tier and Billing Patterns

The patterns that prevent the most billing bugs are the ones that refuse to encode "is this user allowed to do X" deep in the call stack. Keep tier checks at the boundary. Keep the AI experience the same across tiers. Trust the database for plan state, never the session cookie.

## Process

1. **Trial users get the same features as paid users.** Same models, same per-generation limits, same quality. Trial is a *quantity* gate (credits, days), not a *quality* gate. Degrading trial output to push conversions teaches users that paying makes the product worse than the demo.
2. **Use a safe tier accessor with a defined default.** `getTierConfig(tier)` falls back to a known-safe config (typically trial) for unknown values. Direct lookups like `TIER_CONFIGS[tier]` crash on legacy enum values you forgot existed.
3. **Admin checks are a boolean column, not a tier value.** `profile.is_super_admin` survives tier renames and reorganizations. `tier === 'super_admin'` does not.
4. **Verify Stripe webhook signatures with `parseEventNotification`** (Stripe SDK v20+). `parseThinEvent` was renamed and silently doesn't exist on newer SDKs. The webhook will appear to "work" but signature verification is skipped.
5. **For Stripe v20+, `subscription.current_period_end` lives at `items.data[0].current_period_end`.** Reading it off the subscription object directly returns `undefined`, and your trial-expiry cron silently does nothing every day until someone notices revenue is wrong.
6. **AI calls that need structured JSON output should use OpenAI, not Anthropic.** `jsonMode: true` works reliably on GPT-4o and GPT-4o-mini and fails silently (or returns mangled output) on Claude models. If your billing depends on a structured response, this matters.

## Example

```typescript
// Safe accessor: always returns a config, never throws
export function getTierConfig(tier: string): TierConfig {
  return TIER_CONFIGS[tier] ?? TIER_CONFIGS.trial;
}

// Admin by boolean column, not enum value
const isAdmin = profile.is_super_admin === true;

// Stripe v20+: period end lives on the subscription item
const periodEnd = subscription.items.data[0]?.current_period_end;
if (!periodEnd) {
  throw new Error('Subscription has no items. This should not happen.');
}

// Webhook signature verification (v20+)
const event = stripe.webhooks.parseEventNotification(
  rawBody,
  request.headers.get('stripe-signature')!,
  process.env.STRIPE_WEBHOOK_SECRET!,
);

// JSON-mode AI calls go through OpenAI
const response = await callAI(prompt, {
  preferredProvider: 'openai',  // jsonMode is OpenAI-only in practice
  jsonMode: true,
});
```

## Rules

- **Tier checks live at the route handler, not in the business logic.** Deep checks are hard to test, easy to skip, and impossible to audit. Gate at the boundary.
- **One source of truth for plan pricing.** Database, Stripe, and code should all read from the same place, or you will charge the wrong amount and discover it from a support ticket.
- **Legacy enum values can't be `DROP VALUE`d in Postgres.** Keep no code paths reading from them, but expect them to exist forever. Plan migrations around that constraint, not against it.
- **Never expose service-role keys to the client.** They bypass RLS. The "we'll just check on the client" pattern is how data leaks ship.
- **Cron-driven billing transitions need bearer-token auth, not cookie auth.** Crons don't carry sessions. A trial-expiry cron protected by cookie middleware does nothing in production.
- **Plan state is a database read, not a session claim.** Sessions are stale. The DB is the truth.
