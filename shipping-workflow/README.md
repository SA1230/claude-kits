# Shipping Workflow Kit

A portable skill kit for Claude Code that gives every project a disciplined build-ship-verify loop. Install once, use everywhere.

## Philosophy

Ship small, ship often, ship safely. Every change goes through the same pipeline: quality gates, self-review, meaningful commit, PR, merge, health check. No shortcuts. No "I'll fix it later." The pipeline is the product.

## What's included

### Skills (invoke with `/skillname`)

| Skill | Purpose | When to use |
|-------|---------|-------------|
| `/ship` | Build, commit, push, merge | After finishing a task on a feature branch |
| `/kickoff` | Session start with full context | Beginning of every session |
| `/wrapup` | Session end with cleanup | Before closing a chat |
| `/guard` | Pre-ship documentation gate | Between finishing code and `/ship` |
| `/sweep` | Repository hygiene | Monthly, or when things feel messy |
| `/pulse` | Post-deploy health check | After deploys, or when something feels off |

### Skill flow

```
/kickoff  -->  [do work]  -->  /guard  -->  /ship  -->  /pulse
                                                           |
/sweep (periodic)                                     /wrapup
```

### Templates

| File | Purpose |
|------|---------|
| `templates/ci.yml` | GitHub Actions CI (lint + build + test) |
| `templates/flight-manifest.md` | Multi-session coordination |
| `templates/launch.json` | Dev server config for Claude Code preview |
| `claude-md-fragment.md` | Drop-in CLAUDE.md section for any project |

### Hooks

| File | Purpose |
|------|---------|
| `hooks/pre-push-gate.sh` | Blocks pushes that fail lint/build/test |

## Installation

1. Copy this kit to `~/.claude/kits/shipping-workflow/`
2. Skills are automatically available as slash commands in any project
3. Copy `templates/ci.yml` to `.github/workflows/ci.yml` in your project
4. Copy `templates/launch.json` to `.claude/launch.json` in your project
5. Append `claude-md-fragment.md` to your project's `CLAUDE.md`
6. Set up the pre-push hook (see below)

### Pre-push hook setup

Add to your project's `.claude/settings.local.json`:

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash(git push:*)",
        "hooks": [
          {
            "type": "command",
            "command": "bash ~/.claude/kits/shipping-workflow/hooks/pre-push-gate.sh"
          }
        ]
      }
    ]
  }
}
```

## Design principles

- **Project-agnostic.** No references to specific frameworks, databases, or hosting platforms. Works with any stack.
- **Opinionated defaults, flexible execution.** The pipeline order is fixed. The tools within each step adapt to what's available.
- **MCP-aware.** Skills detect and use available MCP connectors (hosting, database, etc.) without requiring them.
- **Fail-safe.** If a tool isn't available, the skill reports what it can't check rather than silently skipping it.
- **Idempotent.** Running any skill twice produces the same result. No side effects from re-runs.
