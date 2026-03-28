# Flight Manifest

Multi-session coordination file. Multiple Claude Code sessions read/write this file to avoid collisions. This file is NOT in git — it lives in the Claude memory directory.

## Active Flights

| Branch | Task | Status | Agent | Timestamp |
|--------|------|--------|-------|-----------|
| _example: feat/add-auth_ | _Add Google OAuth login_ | _In progress_ | _Session 1_ | _2025-01-15 14:30 UTC_ |

## Rules

### Claiming a task

1. **Read this table first** before starting any work.
2. **Check open PRs** (`gh pr list --state open`) to see what's already in flight.
3. **Check remote branches** (`git branch -r`) to see active work.
4. **Add your row** before writing any code. Include branch name, task description, and current UTC timestamp.
5. **If your task is already claimed** or has an open PR — STOP. Tell the user and ask what to do instead.

### While working

- **Don't edit shared files** (CLAUDE.md, MEMORY.md, package.json, core type files) during active work. Save those edits for your landing step.
- **Use `feat/<task-name>` branch naming.** If the branch exists remotely, append a suffix (e.g., `feat/task-name-v2`).
- **Don't touch other agents' state.** Unfamiliar stashes, branches, or lock files belong to someone else.
- **If `git index.lock` exists** — wait 5 seconds and retry. If it persists, report it rather than deleting it.

### Landing (shipping)

1. Rebase on latest main before committing.
2. Apply any shared-file edits NOW (after rebase gives you the latest versions).
3. Run build + tests — must pass.
4. Check for conflicts with other open PRs touching the same files.
5. Ship via `/ship`.
6. Update your row: change status to "PR #X open" or "Merged".

### Collision avoidance

- **One task per session.** Don't combine unrelated changes.
- **Never force-push.** Rebase and try again.
- **If two PRs both edit shared files** — the second PR notes in its description that it needs rebase after the first merges.
- **Stale flight detection** — if a row hasn't been updated in 24 hours, it's probably abandoned. Note it to the user but don't remove it yourself.

## Recently Landed

| Branch | PR | Merged | Summary |
|--------|----|--------|---------|
| _example: feat/add-auth_ | _#42_ | _2025-01-15_ | _Google OAuth with JWT sessions_ |
