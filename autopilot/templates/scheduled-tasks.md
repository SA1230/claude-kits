---
name: scheduled-automations
description: Configured and suggested background automations for this project
type: reference
---

# Scheduled Automations

Track background workflows that maintain project quality between sessions.

## Active

<!-- Add configured automations here. One section per task. -->

<!--
### Example: Weekly Drift Check
- **Task ID:** `weekly-drift-check`
- **Schedule:** `7 9 * * 1` (Mondays at 9:07am local)
- **Skill:** `/drift`
- **Purpose:** Catch CLAUDE.md rot before it misleads a future session
- **Scope:** Persistent (survives restarts) / Session-only
- **Notifications:** On completion
- **Last run:** —
- **Status:** Not yet run
-->

## Suggested (not yet configured)

<!-- Suggestions from /autopilot based on installed kits. -->
<!-- Run /autopilot to populate this section. -->

- `/drift` weekly — catch documentation rot before it causes confusion
- `/pulse` every 6h — verify deploys are healthy between sessions
- `/sweep` weekly — prune stale branches and trim memory files

## Retired

<!-- Move automations here when they are no longer needed, with the reason. -->

<!--
### Example: Retired Task
- **Retired:** 2026-03-15
- **Reason:** Replaced by more specific automation
-->

---
Last updated: —
