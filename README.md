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
│   └── backend-engineer.md            # Example agent with memory integration
├── agent-memory/                      # Per-agent persistent knowledge
│   └── backend-engineer/
│       └── MEMORY.md                  # Memory index (loaded every session)
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

## Learn More

This template accompanies the full guide: **[Shipping with Agents](https://stylusnexus.github.io/shipping-with-agents/)** — advanced Claude Code patterns from a production team.

## License

CC BY-SA 4.0
