# Autopilot Kit

A portable skill kit for Claude Code that maintains project quality between sessions. Install once, stop worrying about what rots while you sleep.

## Philosophy

Quality degrades silently. Branches go stale. Deploys break without anyone checking. Documentation drifts from reality. Memory files reference functions that were renamed two weeks ago. None of this is urgent — until it causes a 30-minute debugging detour because you trusted a stale reference.

Autopilot handles the work that happens without your active attention. It turns manual maintenance skills into scheduled workflows and catches documentation rot before it misleads you.

The unique power: **the system watches while you sleep.**

## What's included

### Skills (invoke with `/skillname`)

| Skill | Purpose | When to use |
|-------|---------|-------------|
| `/autopilot` | Configure scheduled workflows | When setting up or reviewing background automations |
| `/drift` | Detect documentation/code divergence | Before trusting docs, after big refactors, or on a schedule |

### Skill flow

```
/autopilot  -->  configure schedules for:
                   - /drift (weekly)
                   - /pulse (every 6h)
                   - /sweep (weekly)
                   - any other installed skills

/drift      -->  scan CLAUDE.md, memory, skills
                   - report stale references
                   - report missing entries
                   - suggest fixes (never auto-fix)
```

### Templates

| File | Purpose |
|------|---------|
| `templates/scheduled-tasks.md` | Document configured and suggested automations |
| `claude-md-fragment.md` | Drop-in CLAUDE.md section for any project |

## Installation

1. Copy this kit to `~/.claude/kits/autopilot/`
2. Skills are automatically available as slash commands in any project
3. Append `claude-md-fragment.md` to your project's `CLAUDE.md`
4. Run `/autopilot` to configure background workflows based on your installed kits

## Design principles

- **Project-agnostic.** No references to specific frameworks, databases, or hosting platforms. Works with any stack that has a CLAUDE.md.
- **Read-before-write.** `/drift` never auto-fixes. It reports divergence and suggests what to do. You decide.
- **Conservative defaults.** Start with few automations. Add more as confidence builds. A noisy automation is worse than no automation.
- **Graceful degradation.** If scheduled-tasks MCP tools are unavailable, falls back to CronCreate. If that's unavailable, documents the schedule for manual execution.
- **Non-blocking.** Failures get reported, never retried automatically. No automation should block your active work.
- **Composable.** Autopilot orchestrates skills from other kits. It does not duplicate their logic.
