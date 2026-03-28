## Background Automations (Autopilot Kit)

Quality degrades between sessions. Documentation drifts from reality. Deploys break without anyone checking. Two skills handle this:

- **`/autopilot`** — Configure scheduled workflows that run in the background. Detects installed kits and suggests relevant automations (health checks, hygiene passes, drift scans). Manages the schedule, reports failures, never retries automatically. Start here to set up background maintenance.
- **`/drift`** — Scan documentation against the actual codebase. Verifies every file path, exported function, type, and command mentioned in CLAUDE.md, memory files, and skill definitions. Reports stale references and missing entries with line numbers. Read-only — never auto-fixes. Run `/guard` to apply fixes.

### Automation principles

- Background tasks only fire while Claude is idle — they never interrupt active work
- Failures are reported, never retried automatically
- No automation performs destructive operations (delete, force-push, reset)
- Session-scoped automations disappear when Claude exits; use `/autopilot` to re-create them or configure persistent tasks
- Run `/autopilot` at session start to review automation health, or periodically to adjust schedules

### Recommended schedule

| Automation | Cadence | Purpose |
|-----------|---------|---------|
| `/drift` | Weekly | Catch documentation rot before it misleads |
| `/pulse` | Every 6h | Verify deploys are healthy between sessions |
| `/sweep` | Weekly | Prune stale branches and trim memory |
