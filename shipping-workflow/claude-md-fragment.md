# Shipping Workflow (paste into your project's CLAUDE.md)

## Shipping Pipeline

Every change follows the same pipeline: quality gates, self-review, commit, PR, merge, health check.

**Skills (invoke with `/skillname`):**
- `/kickoff` — Start a session: sync main, check state, present briefing
- `/guard` — Pre-ship documentation gate: check if docs match the code
- `/ship` — Build, commit, push, merge in one step. Invoking = explicit approval to push + merge
- `/pulse` — Post-deploy health check: verify production after shipping
- `/wrapup` — End a session: check for dangling work, extract lessons, prep for next time
- `/sweep` — Repository hygiene: prune branches, trim memory, audit docs (monthly)

**Pipeline flow:**
```
/kickoff  →  [do work]  →  /guard  →  /ship  →  /pulse  →  /wrapup
```

## Flight Control Protocol (multi-session coordination)

Multiple Claude Code sessions may run in parallel. This protocol prevents collisions.

The shared state file is the flight manifest (not in git — lives in the Claude memory directory).

### Pre-flight (session start)

1. Read the flight manifest — check Active Flights for tasks already claimed
2. Check open PRs — `gh pr list --state open`
3. Check remote branches — `git branch -r`
4. Claim your task — add a row to the manifest before writing code
5. If your task is already claimed — STOP and tell the user

### In-flight (while working)

1. Controlled Airspace files — do NOT edit CLAUDE.md, MEMORY.md, package.json, or core type files during active work. Apply edits during landing
2. Branch naming — `feat/<task-name>` format
3. Don't touch other agents' state
4. If `git index.lock` exists — wait 5 seconds, retry, then report

### Landing (shipping)

1. Rebase on latest main
2. Apply controlled-airspace edits NOW
3. Run build + tests — must pass
4. Check for conflicts with other open PRs
5. Ship via `/ship`
6. Update the manifest

### Collision avoidance

- One task per session
- Never force-push
- If two PRs edit shared files, the second notes it needs rebase after the first merges
- Flights idle for 24+ hours are probably abandoned — note to user, don't remove

## Infrastructure

- **CI (GitHub Actions):** `.github/workflows/ci.yml` runs lint + build + test on every PR and push to main
- **Pre-push hook:** Runs lint + build + tests before any `git push`. Blocks the push on failure
- **Dev server preview:** `.claude/launch.json` configures dev server. Use `preview_start` with name `"dev"` to launch
