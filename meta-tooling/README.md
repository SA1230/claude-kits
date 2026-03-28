# Meta-Tooling Kit

A portable skill kit for Claude Code that builds the agents that improve other agents. Five skills and a skills catalog template for any project that takes its Claude Code setup seriously.

## Philosophy

Meta-tooling pays off fastest when the ecosystem already has 10+ skills. Below that, you're investing in infrastructure for infrastructure. Above that, you're drowning in agents nobody maintains, skills that overlap, and memory files that lie. The sweet spot is an ecosystem that grows deliberately, prunes regularly, and knows itself.

A good agent ecosystem is like a good team: each member has a clear role, nobody duplicates work, and the gaps between them are small. The goal is not to have the most agents -- it's to have the right ones. `/builder` finds the gaps. `/subtractor` closes the redundancies. `/agent-zero` keeps the foundation solid. `/metrics` tells you what actually happened. `/eli5` makes sure everyone understands what's going on.

## What's included

### Skills (invoke with `/skillname`)

| Skill | Purpose | When to use |
|-------|---------|-------------|
| `/agent-zero` | Audit and optimize Claude Code setup | Periodically, after infra changes, when setup feels suboptimal |
| `/builder` | Analyze friction, propose new agents | At inflection points, after shipping sprints, when workflows feel clunky |
| `/subtractor` | Find and remove dead code, dead features, dead abstractions | When the codebase feels heavy, after a shipping sprint, when deciding what to cut |
| `/metrics` | Query the data layer to answer product questions | When asking "is this working?", after shipping features, validating assumptions |
| `/eli5` | Explain anything in plain language | After dense discussions, before demos, when sharing with non-technical people |

### Skill flow

```
/agent-zero  -->  [identify infrastructure gaps]
     |
     v
/builder     -->  [propose new skills from evidence]
     |
     v
[build + ship]
     |
     v
/subtractor  -->  [prune what's dead]
     |
     v
/metrics     -->  [measure what shipped]
     |
     v
/eli5        -->  [explain what we learned]
```

The cycle runs continuously. `/agent-zero` and `/builder` expand. `/subtractor` contracts. `/metrics` measures. `/eli5` communicates. Growth without pruning is hoarding. Pruning without measurement is guessing.

### Memory templates

| File | Purpose |
|------|---------|
| `memory-templates/skills-catalog.md` | Template for tracking all installed skills with categories and relationships |

### Composable fragments

| File | Purpose |
|------|---------|
| `claude-md-fragment.md` | Drop-in CLAUDE.md section about meta-tooling philosophy |

## Installation

1. Copy this kit to `~/.claude/kits/meta-tooling/`
2. Skills are automatically available as slash commands in any project
3. Copy `memory-templates/skills-catalog.md` to your project's memory directory and fill it in
4. Append `claude-md-fragment.md` to your project's `CLAUDE.md`

## Design principles

- **Project-agnostic.** No references to specific frameworks, databases, or tools. Works with any stack.
- **Non-destructive.** Analysis skills read everything, modify nothing. `/subtractor` presents a list -- it never auto-deletes.
- **Evidence-based.** Every recommendation cites the file, line, or pattern that triggered it. No vibes-only advice.
- **Re-runnable.** Running any skill twice produces the same result. No side effects from re-runs.
- **Composable.** Each skill works alone. Together they form a maintenance loop. Neither mode is second-class.
