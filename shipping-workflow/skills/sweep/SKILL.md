---
name: sweep
description: "Repository hygiene. Prune branches, trim memory, audit docs. Maintenance only."
---

# /sweep — Repository Hygiene

You are a janitor with read access to everything and write access to only the safe things. Your job is to clean up the accumulated cruft that builds up over time — stale branches, bloated memory files, outdated references. You never delete anything that might be needed. You never edit code.

## Rules

- **MAINTENANCE only.** Do not edit source code, application logic, or configuration.
- **Never delete unmerged branches.** Only prune branches that have been merged into main.
- **Never edit CLAUDE.md content directly.** Report inaccuracies. Let the user or `/guard` fix them.
- **Idempotent.** Running `/sweep` twice in a row should produce no changes on the second run.
- **Report everything you do.** No silent operations.

## Steps

### Step 1: Prune stale remote branches

Find branches that have been merged into main:

```bash
git fetch --prune
git branch -r --merged origin/main | grep -v 'origin/main' | grep -v 'origin/HEAD'
```

For each merged branch, delete the remote ref:
```bash
git push origin --delete <branch-name>
```

Report how many branches were pruned and their names.

Skip branches less than 24 hours old (they might be part of an active PR flow).

### Step 2: Clean local branches

```bash
git branch --merged main | grep -v 'main' | grep -v '\*'
```

Delete merged local branches:
```bash
git branch -d <branch-name>
```

### Step 3: Regenerate skills catalog

If a skills catalog file exists (e.g., `skills-catalog.md` in a memory directory), regenerate it by scanning `.claude/skills/` for all SKILL.md files. Extract name, description, and trigger conditions from each.

If no catalog exists, skip this step.

### Step 4: Prune memory files

If MEMORY.md exists and is over 170 lines:
1. Identify entries older than 30 days (look for date markers, PR numbers with old dates, or explicit timestamps)
2. Move old entries to an archive file (e.g., `memory-archive-YYYY-MM.md`)
3. Replace archived entries with a one-line reference: `> Archived to memory-archive-YYYY-MM.md`

If MEMORY.md is under 170 lines, skip this step.

### Step 5: Rotate failure journal

If a failure log exists (`.claude/hook-failures.log` or similar):
1. Remove entries older than 30 days
2. If the file is now empty, delete it
3. Report how many entries were removed

### Step 6: Audit CLAUDE.md structure

If CLAUDE.md has a project structure section, compare it against the actual filesystem:

```bash
# List actual files in documented directories
ls -la src/  # or whatever the project structure shows
```

Report:
- Files listed in CLAUDE.md that don't exist on disk
- Files on disk in documented directories that aren't listed

Do NOT fix these — just report them. The user or `/guard` decides what to update.

### Step 7: Summary report

Format:

```
## Sweep Report

**Branches pruned:** <N remote, M local>
<list of pruned branches>

**Memory:** <trimmed N lines / no changes needed>

**Failure journal:** <removed N old entries / not found>

**CLAUDE.md accuracy:**
- Missing from docs: <files>
- Missing from disk: <files>
- Accurate: <yes/no>

**Skills catalog:** <regenerated / not found / up to date>
```
