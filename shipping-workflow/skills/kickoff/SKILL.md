---
name: kickoff
description: "Start a new session with full context. Sync, check state, present briefing."
---

# /kickoff — Session Start

You are a briefing officer. Your job is to get the developer oriented fast — what's the state of the repo, what shipped recently, what's broken, what's pending. You gather intel and present it concisely. You do not make changes.

## Rules

- **READ-ONLY.** Do not modify any files, make commits, or change branches (except syncing main).
- **Concise.** The briefing should be scannable in 10 seconds. Use bullets, not paragraphs.
- **Flag broken builds as top priority.** If CI is red or build fails, that's the first thing the user sees.
- **Don't run build+test unless there's reason to.** Check CI status first. Only run locally if CI shows failures or hasn't run recently.
- **Adapt to what exists.** Not every project has memory files, CI, or open PRs. Report what's available, skip what isn't.

## Steps

### Step 1: Sync main

```bash
git fetch origin
git checkout main
git pull origin main
```

If the working tree is dirty, report the uncommitted changes but do NOT discard them. Stash if needed to switch branches, then unstash after.

If `git pull` fails due to conflicts, report the conflict and stop — this needs human intervention.

### Step 2: Read memory files

Check for and read (if they exist):
- `CLAUDE.md` in the project root
- `MEMORY.md` in the project root or Claude memory directory
- Any `reviews.md` or similar review history files

Don't fail if these don't exist. Just note "No memory files found."

### Step 3: Check project state (parallel)

Run these in parallel:

**Recent history:**
```bash
git log --oneline -10
```

**Open PRs:**
```bash
gh pr list --state open
```

**CI status (if available):**
```bash
gh run list --limit 3
```

**Remote branches:**
```bash
git branch -r --sort=-committerdate | head -10
```

Only run `npm run build` and `npm test` locally if:
- CI shows recent failures, OR
- There are no recent CI runs, OR
- The user explicitly asks

### Step 4: Check failure patterns

Look for `hook-failures.log` or similar failure logs in `.claude/` or the project root.

If found:
- Read the last 20 entries
- Group by failure type (lint, build, test)
- Surface recurring patterns ("build has failed 4 of last 6 pushes — type errors in X")

### Step 5: Surface deferred items

If memory files exist, scan for:
- Items marked as "deferred" or "TODO"
- Items from the most recent review/audit
- Known issues or planned improvements

List the top 3-5 most relevant deferred items.

### Step 6: Present session briefing

Format:

```
## Session Briefing

**Branch:** main (clean / dirty)
**Last commit:** <hash> <message> (<time ago>)
**Build:** passing / failing / unknown
**Tests:** passing / failing / unknown

**Open PRs:** <count>
- #<num>: <title> (by <author>)

**Recently shipped:**
- <PR or commit summary>
- <PR or commit summary>

**Failure patterns:** <none / summary>

**Deferred items:**
- <item>
- <item>

**Ready for:** <what the session is set up to do>
```

The "Ready for" line should be a practical suggestion based on what you found — "Ready for new feature work" if everything is clean, "Build is broken — fix that first" if CI is red, "PR #42 needs review" if there's a stale PR.
