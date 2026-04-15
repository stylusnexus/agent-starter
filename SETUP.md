# Claude Code Project Setup

> **For Claude**: Read this document, then follow the workflow below to set up a project for effective agent-assisted development. Scan the project first, ask the user targeted questions, then generate the right files.
>
> **For you**: Point Claude at this doc with: "Read `SETUP.md` and set up this project."

---

## Phase 1: Discover

Scan the project to understand what exists before generating anything.

### Run These Commands

```bash
# What kind of project is this?
ls package.json pyproject.toml Cargo.toml go.mod Gemfile pom.xml build.gradle *.csproj 2>/dev/null

# What's the directory structure?
ls -la
ls src/ app/ lib/ pages/ components/ 2>/dev/null

# What tooling exists?
ls .eslintrc* .prettierrc* tsconfig.json vitest.config* jest.config* playwright.config* 2>/dev/null

# What scripts are available?
cat package.json | grep -A 30 '"scripts"' 2>/dev/null || cat pyproject.toml 2>/dev/null | grep -A 20 '\[tool\.'

# Does any Claude config exist already?
ls CLAUDE.md .claude/ .cursorrules .github/copilot-instructions.md 2>/dev/null

# What env files exist?
ls .env* 2>/dev/null

# Git status
git log --oneline -5 2>/dev/null
git remote -v 2>/dev/null

# Check for database
ls supabase/ prisma/ drizzle/ migrations/ 2>/dev/null
grep -l "DATABASE_URL\|SUPABASE\|PRISMA\|MONGO" .env* 2>/dev/null
```

### Classify the Project

Based on the scan, determine:

| Signal | Classification |
|--------|---------------|
| `package.json` + `next.config.*` | Next.js app |
| `package.json` + `vite.config.*` | Vite app (React/Vue/Svelte) |
| `package.json` + no framework config | Node.js library or API |
| `pyproject.toml` or `requirements.txt` | Python project |
| `Cargo.toml` | Rust project |
| `go.mod` | Go project |
| Empty directory | New/greenfield project |

Detect the following capabilities (present or not):
- [ ] TypeScript
- [ ] Testing framework (which one?)
- [ ] Linter/formatter
- [ ] Database (which one?)
- [ ] Auth system
- [ ] CI/CD pipeline
- [ ] Deployment target
- [ ] Docker

### Visual Planning (Phase 1.5)

After classification, run `/visualize-project` to generate architecture diagrams before proceeding to Phase 2. The skill scores project complexity from the signals above and generates tiered Mermaid diagrams:

- **Simple (score 0-1):** Module overview only (~30 seconds)
- **Standard (score 2-4):** Module map + data flow + route tree (~2 minutes)
- **Complex (score 5+):** Full blueprint with ER diagram, service topology, timeline (~5 minutes)

You can upgrade, accept the recommendation, or skip.

### Ask the User

After scanning, ask these questions (skip any you can already answer from the scan):

1. **"What does this project do, in one sentence?"**
2. **"What's the tech stack?"** (confirm what you detected)
3. **"Are there any compliance or legal constraints?"** (e.g., HIPAA, PCI, content licensing)
4. **"What's your deployment target?"** (Render, Vercel, AWS, etc.)
5. **"Any patterns from other projects you want carried over?"** (e.g., commit conventions, test strategy)
6. **"What's the current state?"** (greenfield, early development, mature, legacy rescue)

---

## Phase 2: Generate CLAUDE.md

Create `CLAUDE.md` in the project root. Adapt the template below based on Phase 1 findings. Only include sections that are relevant. Don't add placeholder sections.

### Core Sections (always include)

```markdown
# CLAUDE.md

## Project Overview
[Fill from user's one-sentence description + detected stack]

## Development Commands
[Fill from detected package.json scripts, Makefile targets, etc.]
```bash
[dev command]       # Start dev server
[build command]     # Production build
[test command]      # Run tests
[lint command]      # Lint/format
```

## Pre-Commit Checklist
**Code changes**: MUST run `[build command]` before committing.
[Add test/lint commands if they exist]

**Documentation only** (.md files): Skip build, commit directly.

## Architecture
[Fill from directory scan. Describe what lives where.]

## Common Gotchas
1. [Add at least one from what you observed during setup]
```

### Conditional Sections (include only when detected)

**If TypeScript detected:**
```markdown
## Type Safety
Key type files: [list detected .d.ts, types/ directories]
Pattern: [regeneration instructions if using codegen like Supabase/Prisma]
```

**If database detected:**
```markdown
## Database
[Connection details from env files. Names only, not values.]
Migration location: [detected path]
Migrations MUST be idempotent (IF NOT EXISTS, DROP IF EXISTS).
```

**If auth detected:**
```markdown
## Authentication
Client: [pattern]
Server: [pattern]
NEVER: [security constraints, e.g., expose service keys client-side]
```

**If compliance constraints exist:**
```markdown
## Compliance
[Rules from user's answer to compliance question]
```

**If CI/CD detected:**
```markdown
## CI/CD
[Pipeline description from .github/workflows, etc.]
```

**If deployment target known:**
```markdown
## Deployment
Platform: [target]
Production URL: [if known]
```

### Commit Conventions

Default to Conventional Commits unless the user specifies otherwise:
```markdown
## Commit Conventions
Format: `type(scope): description`
Types: feat, fix, chore, docs, test, refactor, perf, ci
```

---

## Phase 3: Generate Support Files

### Always Create

```
.claude/                    # Claude Code configuration directory
```

### Create If the Project Has 3+ Modules or Domains

```
.claude/guidances/          # Domain-specific context (split from CLAUDE.md later)
```

Write a starter guidance only if you detected a complex domain during scanning (e.g., a testing setup with multiple frameworks, a multi-service architecture).

### Create a Starter Skill When a Repeated Workflow is Obvious

Common candidates detected from project structure:

| If you detect... | Create skill |
|-----------------|-------------|
| Test framework + components | `.claude/skills/new-component.md` |
| API routes directory | `.claude/skills/new-api-route.md` |
| Database + migrations | `.claude/skills/new-migration.md` |
| Multiple services/packages | `.claude/skills/new-service.md` |

Skill format:
```markdown
---
name: [skill-name]
description: [when to use this]
---

## Steps
1. [Concrete step with file paths]
2. [Concrete step]
3. [Verification step. Run a command to confirm it works.]
```

### Do NOT Create Yet

- Agents (`.claude/agents/`) -- wait until there are genuinely distinct domains
- Memory directories -- Claude Code creates these automatically
- Guidances -- wait until CLAUDE.md exceeds ~500 lines

---

## Phase 4: Verify the Setup

Run these checks before reporting completion:

```bash
# CLAUDE.md exists and is non-empty
test -s CLAUDE.md && echo "CLAUDE.md: OK"

# Every command documented in CLAUDE.md actually works
# Run each dev/build/test/lint command and confirm it succeeds

# .claude/ directory exists
test -d .claude && echo ".claude/: OK"

# If skills were created, they have valid frontmatter
# Check each .claude/skills/*.md has --- name/description ---
```

**Report to the user:**
- What was created and why
- What was intentionally skipped and why
- The first gotcha you discovered during setup
- One suggested next step (e.g., "run the dev server and verify it starts")

---

## Reference: Growth Triggers

These milestones tell you when to evolve your setup:

| Milestone | Action |
|-----------|--------|
| Same instruction given 3+ times | Create a `.claude/skills/` skill for it |
| CLAUDE.md hits 500+ lines | Split into `.claude/guidances/` by domain |
| 2+ distinct work domains emerge | Create first `.claude/agents/` agent |
| Agent makes same mistake twice | Add to Common Gotchas in CLAUDE.md |
| Complex verification needed | Add to pre-commit checklist |
| New env file or service added | Update Environment section |
| First deployment | Add Deployment section |

## Reference: Anti-Patterns

When setting up, avoid:

1. **Placeholder sections** -- don't add "## Authentication" with "[TODO]". Only add sections you can fill now.
2. **Aspirational commands** -- only document commands that actually work today.
3. **Over-scaffolding** -- no agents, guidances, or complex skill trees for a new project. Start minimal.
4. **Duplicating README** -- CLAUDE.md is agent context, not user documentation. Focus on gotchas, patterns, and constraints that prevent mistakes.
5. **Generic advice** -- "write clean code" helps nobody. "Always use parameterized queries, never string concatenation" prevents a bug.

## Reference: Recommended Defaults

Apply these unless the project specifies otherwise:

- **Commit conventions**: Conventional Commits, enforced on PR titles
- **Branch strategy**: Feature branches with issue numbers (e.g., `feat/1748-feature-name`)
- **Never commit directly to main** -- always feature branch first
- **Guardrails philosophy**: Control AI output, never police user input
- **Verification**: Evidence before assertions. Run the command, don't assume it passes.

---

*Part of the [Agent Starter](https://github.com/stylusnexus/agent-starter) template by [Stylus Nexus](https://github.com/stylusnexus). Full guide: [Shipping with Agents](https://stylusnexus.github.io/shipping-with-agents/).*
