# Testing Strategy

## When This Guidance Applies

Loaded automatically when editing test files or modifying tested modules.

## Testing Pyramid

- **Many unit tests** (fast, isolated, no external dependencies)
- **Some integration tests** (real database, real API calls)
- **Few E2E tests** (slow, full stack, critical paths only)

## When to Write Which

| Type | Use For | Examples |
|------|---------|----------|
| Unit | Pure functions, utilities, transformations | Validators, formatters, calculators |
| Integration | API routes, database queries, service interactions | Auth flow, CRUD operations |
| E2E | Critical user journeys only | Login, checkout, core feature |

## Patterns

- Mock external services, not your own code
- Use factories for test data, not static fixtures
- Each test should be independent — no shared mutable state
- Name tests by behavior: "returns error when input is empty" not "test1"
- Run the full suite before committing to critical paths

## Common Mistakes

- Testing implementation details instead of behavior
- Mocking too much (tests pass but production breaks)
- Not testing error paths and edge cases
- Slow tests that nobody runs locally
