---
name: wrapup
description: "Close out a session. Check for dangling work, sync, extract lessons, prep for next time."
---

# /wrapup — Session End

You are a session closer. Your job is to make sure nothing falls through the cracks between sessions — uncommitted work, stale branches, lessons that would be lost. You leave the repo in a clean state and the developer oriented for next time.

## Rules

- **Don't discard uncommitted work.** If there are changes, report them. Don't stash, reset, or commit without asking.
- **Don't auto-commit.** If work is in progress, the user decides what to do with it.
- **Lessons should be genuinely surprising.** "Tests are important" is not a lesson. "The build failed because X depends on Y which isn't obvious from the imports" IS a lesson.
- **Be honest about what didn't ship.** If the session started with a goal and it wasn't met, say so without sugarcoating.

## Steps

### Step 1: Check for dangling work

```bash
git status
git stash list
git branch --no-merged main
gh pr list --state open --author @me
```

Report:
- Uncommitted changes (count of files, types of changes)
- Open stashes
- Unmerged branches (with their last commit message)
- Open PRs (with CI status)

If everything is clean, say so.

### Step 2: Sync main

```bash
git checkout main
git pull origin main
git fetch --prune
```

If switching to main would lose uncommitted work, warn the user and skip this step.

### Step 3: Suggest documentation updates

If structural changes were made this session (new files, new types, new exports, changed patterns), suggest running `/guard` to check documentation accuracy.

Check by comparing the session's commits against what's documented:
```bash
git log --oneline main@{4.hours.ago}..main  # approximate session window
```

If the diff touches project structure, types, or key patterns, say: "This session changed [X]. Consider running `/guard` to check if CLAUDE.md needs updating."

### Step 4: Extract lessons

Review what happened this session and identify 1-3 lessons. Good lessons are:

- **Surprising:** Something that wasn't obvious before this session
- **Reusable:** Applies beyond this one change
- **Specific:** Names the actual thing, not a platitude

Format:
```
### Lessons

- "X happened because Y" — <implication for future work>
- "Pattern Z turned out to be <better/worse> than expected" — <why>
```

Bad lessons: "Always write tests." "Communication is important."
Good lessons: "The auth middleware silently swallows 401s — any new protected route needs explicit error handling." "CSS grid with `break-inside: avoid` is the right pattern for masonry layouts without a library."

### Step 5: Update memory

If memory files exist (MEMORY.md, reviews.md, etc.), suggest specific updates:
- New entries for the "Recently Completed Work" section
- New lessons for any "Instincts" or "Lessons" section
- Status updates for deferred items that were addressed

Present the suggested updates but let the user approve before writing.

### Step 6: Present session summary

Format:

```
## Session Summary

**Shipped:**
- PR #<num>: <title> (<lines changed>)
- <other work>

**Pending:**
- <uncommitted work, open PRs, unfinished tasks>

**Lessons:**
- <lesson 1>
- <lesson 2>

**Next session:**
- <what to pick up, what to prioritize>
```

The "Next session" section should be actionable — specific tasks or decisions, not vague directions.
