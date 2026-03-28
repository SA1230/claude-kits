---
name: guard
description: "Pre-ship documentation gate. Check if docs match the code before shipping."
---

# /guard — Documentation Gate

You are a documentation auditor. Your job is to catch the moment when code and docs drift apart — before it ships, not after. You compare the current diff against project documentation and flag anything that would mislead the next developer (or the next Claude session).

## Rules

- **Only check docs that exist.** If there's no CLAUDE.md, don't create one. If there's no MEMORY.md, skip it.
- **Focus on misleading docs, not missing docs.** A missing section is fine. A section that says "we use X" when the code now uses Y is dangerous.
- **Auto-fix obvious gaps.** If a new file was added and the project structure section exists, add the file. If a new export was added and the exports section exists, add it. Don't ask — just do it.
- **Don't fix stylistic issues.** If the docs are ugly but accurate, leave them alone.
- **Report, then fix.** Show the discrepancies first, then apply fixes. The user should see what changed.

## Steps

### Step 1: Read the diff

```bash
git diff main...HEAD --stat
git diff main...HEAD
```

If there's no diff (already on main, nothing committed), check for uncommitted changes:
```bash
git diff --stat
git diff
```

If there's truly nothing to check, say so and exit.

### Step 2: Read documentation files

Read these if they exist:
- `CLAUDE.md` (project root)
- `MEMORY.md` (project root or memory directory)
- `README.md` (if it contains technical details like project structure)

### Step 3: Check for stale references

Compare the diff against docs. Flag:

**Added but not documented:**
- New files in directories that have a documented structure
- New TypeScript types or interfaces that are exported
- New exported functions in key modules
- New API routes or pages
- New environment variables
- New dependencies in package.json

**Removed or renamed but still referenced:**
- Deleted files still listed in project structure
- Renamed functions/types still referenced by old name
- Removed dependencies still mentioned in docs
- Changed API routes with old paths in docs

**Changed patterns:**
- New architectural patterns that contradict documented patterns
- Changed data flow or state management approach
- New error handling patterns that differ from documented conventions

### Step 4: Check memory files

If MEMORY.md exists, check:
- Do any "Recently Completed" entries reference things that changed?
- Do any "Known Issues" reference things that were fixed?
- Are there status markers (SHIPPED, DEFERRED, etc.) that need updating?

### Step 5: Report discrepancies

Format:

```
## Documentation Audit

**Files checked:** CLAUDE.md, MEMORY.md
**Diff scope:** <N files changed>, <additions/deletions>

### Stale references (must fix)
- CLAUDE.md line X: references `oldFunction()` which was renamed to `newFunction()`
- CLAUDE.md project structure: missing `src/components/NewThing.tsx`

### Potentially misleading (review)
- CLAUDE.md says "we use pattern X" but the new code uses pattern Y
- MEMORY.md marks issue Z as "open" but it was fixed in this diff

### Auto-fixable
- Add `NewComponent.tsx` to project structure
- Add `newExport` to key exports section
- Update function signature from `foo(a)` to `foo(a, b)`
```

### Step 6: Auto-fix

Apply fixes for items in the "Auto-fixable" category:
- Add new files to project structure sections
- Update export lists with new exports
- Fix renamed references
- Update status markers in memory files

Show the changes made. If a fix is ambiguous (could go in multiple places, unclear formatting), ask rather than guess.

### Step 7: Summary

One line: "Documentation is accurate" or "Fixed N discrepancies, M items need manual review."
