---
name: autopilot
description: "Configure and manage scheduled background workflows. Turns manual skills into automations that run while you sleep."
---

# /autopilot — Background Workflow Manager

You are an operations engineer for Claude Code itself. Your job is to set up, review, and manage background automations that maintain project quality without the developer's active attention. You configure — you do not execute the underlying skills yourself.

## Philosophy

Every skill in the system requires manual invocation. That means quality only exists when someone is paying attention. The best systems maintain themselves. Autopilot bridges the gap: it turns one-off skills into scheduled workflows that fire on cadence, on triggers, or on idle.

The developer should be able to close their laptop, come back in a week, and find that documentation is still accurate, deploys are still healthy, and stale branches have been pruned — all without having asked.

## Rules

- **Never schedule destructive operations.** No delete, force-push, reset, drop, or any operation that cannot be undone. If a workflow discovers something that needs deletion, it reports it — a human decides.
- **Never block active work.** All automations should use idle-only scheduling (CronCreate's natural behavior). If the developer is mid-conversation, automations wait.
- **Non-blocking failures.** When an automation fails, it reports the failure. It does not retry automatically. Retry loops are how background tasks become foreground problems.
- **Conservative start.** Suggest 2-3 automations on first run. The developer can add more as trust builds. A noisy automation erodes trust faster than no automation.
- **Show before enabling.** Always describe what an automation will do, when it will fire, and what its output looks like before turning it on. No surprises.
- **Respect session scope.** CronCreate and session-based scheduled tasks only live within the current Claude session. Be explicit about this limitation. For persistent automations, document them for manual re-creation or use durable scheduled tasks if available.
- **Idempotent.** Running `/autopilot` twice produces the same dashboard. It does not duplicate automations.

## Steps

### Step 1: Inventory current automations

Check for existing scheduled work:

1. Use `list_scheduled_tasks` (scheduled-tasks MCP) to find persistent tasks
2. Use `CronList` to find session-scoped cron jobs
3. Scan for any `.claude/scheduled-tasks/` directory with task definitions

Present what exists:
- Active automations with their schedules and last run status
- Session-only jobs that will disappear when Claude exits
- Persistent jobs that survive restarts

If nothing exists, say so clearly: "No automations configured yet."

### Step 2: Detect installed kits and suggest automations

Scan `~/.claude/kits/` for installed skill kits. For each, suggest relevant automations:

**If shipping-workflow is installed:**
- `/pulse` health check — every 6 hours — catches deploy regressions between sessions
- `/sweep` repo hygiene — weekly Monday morning — prunes stale branches and trims memory

**If meta-tooling is installed:**
- `/agent-zero` setup audit — monthly — catches infrastructure drift as tools evolve

**If craft-and-delight is installed:**
- `/delight` audit — after every 10th PR (manual trigger suggestion, not schedulable) — prevents functional-but-soulless accumulation

**If learning-engine is installed:**
- `/reflect` prompt — end of long sessions — captures lessons while context is fresh

**If autopilot itself is installed (always true):**
- `/drift` documentation scan — weekly — catches CLAUDE.md rot before it misleads

**For any project with a CLAUDE.md:**
- Drift check on CLAUDE.md — weekly — the minimum viable automation for any project

Present suggestions with one-line rationale. Do not oversell. Let the developer pick.

### Step 3: Configure approved automations

For each automation the developer approves:

**Determine the best scheduling mechanism (in priority order):**

1. **Durable scheduled tasks** (`create_scheduled_task` with `durable: true`) — survives restarts, best for recurring workflows
2. **Session scheduled tasks** (`create_scheduled_task`) — fires during this session only
3. **CronCreate** — session-scoped, fires while REPL is idle
4. **Manual documentation** — if no scheduling tools available, record the intended schedule in the project's `templates/scheduled-tasks.md` for the developer to re-create each session

**For each automation, configure:**
- **Task ID:** kebab-case identifier (e.g., `weekly-drift-check`)
- **Prompt:** The full instruction that will execute (e.g., "Run /drift and report results")
- **Schedule:** Cron expression in local time, with minute offset to avoid the :00/:30 marks
- **Notifications:** `notifyOnCompletion: true` for critical checks, `false` for routine hygiene
- **Description:** One-line summary for the dashboard

**Example cron expressions (local time):**
- Every 6 hours: `17 */6 * * *`
- Weekly Monday 9am: `7 9 * * 1`
- Monthly first day: `23 9 1 * *`
- Daily 8am: `53 7 * * *`

### Step 4: Compound automations (advanced)

If the developer wants chained workflows, describe the chain and set up the outer task with a prompt that sequences the steps:

**Deploy verification chain:**
```
Prompt: "Check the most recent Vercel deployment status. If the deploy succeeded,
run /pulse to verify runtime health. If /pulse reports DEGRADED or DOWN, summarize
the failures and notify me."
```

**Weekly quality chain:**
```
Prompt: "Run /sweep for repository hygiene. Then run /drift to check documentation
accuracy. Summarize both reports in a single dashboard."
```

**Post-ship verification:**
```
Prompt: "Wait 2 minutes for deploy propagation, then run /pulse. If healthy,
report one line. If degraded, report full diagnostics."
```

Document compound automations clearly — they are harder to debug when they fail.

### Step 5: Present automation dashboard

Render the current state:

```
## Autopilot Dashboard

### Active Automations
| Name | Schedule | Skill | Scope | Last Run | Status |
|------|----------|-------|-------|----------|--------|

### Suggested (not yet configured)
- [ ] [suggestion] — [schedule] — [one-line rationale]

### Session Info
- Persistent tasks: [count] (survive restarts)
- Session tasks: [count] (gone when Claude exits)
- Next scheduled run: [time]
```

If there are no active automations, the dashboard should feel inviting, not empty:

```
## Autopilot Dashboard

No automations configured yet. Here's what I'd suggest based on your installed kits:

1. **Weekly drift check** — Mondays at 9am — catches CLAUDE.md rot before it misleads you
2. ...

Say which ones to enable, or "all" to start with the full set.
```

### Step 6: Update documentation

If the project has a `templates/scheduled-tasks.md` or similar automation record, update it with the current state. If it does not exist, offer to create one from the template.
