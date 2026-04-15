# Agent Starter

A starter template for advanced Claude Code setups. Fork this repo and customize it for your project.

By [Stylus Nexus](https://github.com/stylusnexus).

## What's Inside

```
CLAUDE.md                              # Project brain — rules, commands, gotchas
.claude/
├── guidances/                         # On-demand domain knowledge
│   ├── ai-safety.md                   # AI input/output safety patterns
│   ├── testing-strategy.md            # When to use unit vs integration vs E2E
│   └── database-patterns.md           # Migrations, queries, security
├── agents/                            # Specialized agent definitions
│   ├── backend-engineer.md            # API design, database, server-side
│   ├── ui-engineer.md                 # Frontend, components, responsive design
│   ├── ux-designer.md                 # User experience, interaction design
│   ├── ai-engineer.md                 # LLM integration, prompts, AI safety
│   ├── product-manager.md             # Feature prioritization, roadmaps
│   └── technical-writer.md            # Documentation, API docs, guides
├── agent-memory/                      # Per-agent persistent knowledge
│   ├── backend-engineer/MEMORY.md
│   ├── ui-engineer/MEMORY.md
│   ├── ux-designer/MEMORY.md
│   ├── ai-engineer/MEMORY.md
│   ├── product-manager/MEMORY.md
│   └── technical-writer/MEMORY.md
├── skills/                            # Workflow discipline skills
│   ├── brainstorm.md                  # Think before you build
│   ├── tdd.md                         # Test-driven development
│   ├── verify.md                      # Verify before claiming done
│   ├── write-plan.md                  # Turn specs into step-by-step plans
│   ├── execute-plan.md                # Work through plans task by task
│   ├── orient.md                      # Rebuild context after /clear
│   ├── debug.md                       # Systematic debugging (diagnose first)
│   ├── review-and-ship.md            # Review, commit, push, PR
│   ├── activity-summary.md            # Repo activity and status snapshot
│   ├── experiment.md                  # Measure, fix, re-measure loop
│   └── deploy.md                      # Ship to production via PR
├── hooks/                             # Automated context injection scripts
│   ├── session-start.sh               # Shows project context on session start
│   ├── domain-context-loader.sh       # Auto-loads relevant guidance by file path
│   ├── require-tests.sh              # Warns if critical code changed without tests
│   └── instrumentation-check.sh      # Reminds to check analytics on API/form edits
└── settings.json                      # Hook wiring configuration
```

## How to Use

1. **Fork this repo** (or copy the `.claude/` directory into your project)
2. **Edit `CLAUDE.md`** — fill in your project overview, dev commands, and gotchas
3. **Customize guidances** — replace the examples with your actual domain knowledge
4. **Add agents** — define specialists for the domains you work in most
5. **Configure hooks** — update the file path patterns in `domain-context-loader.sh`

## Automated Setup

Have an existing project you want to bootstrap? Point Claude at the setup runbook:

```
Read SETUP.md and set up this project.
```

It will scan your codebase, ask targeted questions, and generate a CLAUDE.md and support files tailored to your project. See [SETUP.md](SETUP.md) for the full workflow.

## Recommended Plugins

Plugins extend your Claude Code setup with packaged skills, hooks, and integrations. Install with `claude install-plugin <url>`.

| Plugin | What It Does | Install |
|--------|-------------|---------|
| **Superpowers** | Workflow skills (brainstorm, TDD, verify, plans, review) | `claude install-plugin superpowers` |
| **Hookify** | Create hooks from conversation analysis | `claude install-plugin hookify` |
| **Commit Commands** | Commit, push, and PR in one command | `claude install-plugin commit-commands` |
| **PR Review Toolkit** | Multi-agent code review | `claude install-plugin pr-review-toolkit` |
| **Feature Dev** | Guided feature development with codebase understanding | `claude install-plugin feature-dev` |

Browse more plugins with `claude plugins`.

### MCP Servers (Cross-Tool)

MCP servers work with Claude Code, Cursor, Codex, Windsurf, and Copilot. Add them with `claude mcp add <server>`.

| Server | What It Does |
|--------|-------------|
| [context7](https://github.com/upstash/context7) | Current library/framework docs (prevents stale API advice) |
| [GitHub](https://github.com/github/github-mcp-server) | PR management, issues, CI status |
| [Playwright](https://github.com/microsoft/playwright-mcp) | Browser automation, visual testing |
| [Sentry](https://docs.sentry.io/organization/integrations/integration-platform/mcp-server/) | Error tracking and investigation |

Full directory: [mcpmarket.com](https://mcpmarket.com) (10,000+ servers) or [mcp.so](https://mcp.so) (20,000+).

## Using with Other AI Coding Tools

This starter is built for Claude Code, but the patterns transfer. See the [adapter callouts](https://stylusnexus.github.io/shipping-with-agents/#claude-md) in the Shipping with Agents guide for how each concept maps to:

- **Cursor**: `.cursorrules`, Cursor Marketplace plugins, `@docs` references
- **GitHub Copilot**: `.github/copilot-instructions.md`
- **Windsurf**: `.windsurfrules`, Flows, native Memories
- **Codex**: `AGENTS.md`, Codex plugin directory, transcript persistence

## Companion Guides

- **[Shipping with Agents](https://stylusnexus.github.io/shipping-with-agents/)** — development workflow patterns (agents, skills, hooks, memory)
- **[Testing with Agents](https://stylusnexus.github.io/testing-with-agents/)** — testing patterns (mocks, visual verification, experiment-as-test, CI)
- **[Test Starter](https://github.com/stylusnexus/test-starter)** — fork-ready testing infrastructure (companion to this repo)

## License

CC BY-SA 4.0
