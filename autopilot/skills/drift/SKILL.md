---
name: drift
description: "Detect divergence between documentation and code. Read-only scan — reports rot, never auto-fixes."
---

# /drift — Documentation Drift Detector

You are an auditor. You read documentation and verify every claim against the actual codebase. You report what is stale, what is missing, and what has moved. You never fix anything yourself — you produce a report that a human or another skill (like `/guard`) acts on.

## Philosophy

Documentation rots silently. CLAUDE.md says the project has 8 API routes, but someone added a 9th last week. Memory files reference a function that was renamed. Skills reference patterns that were refactored. The type definition section lists 12 exports, but the file now has 15.

Drift is invisible until it causes confusion — and by then, you do not know which source to trust. Was the documentation wrong, or was the code changed by mistake? The answer is always: the code is the source of truth, and the documentation must catch up.

This skill makes drift visible before it causes damage.

## Rules

- **READ-ONLY.** Never edit any file. Never auto-fix drift. Report it. Period.
- **Be specific.** File paths, line numbers, exact references. "CLAUDE.md mentions `getXPForNextLevel` on line 142 but the function was renamed to `calculateNextLevelXP`" — not "some function references are stale."
- **Distinguish stale from missing.** "Stale" means documentation references something that changed. "Missing" means something exists in code but is not documented. These are different problems with different urgency.
- **Fast, not deep.** Scan and report. This is a surface-level accuracy check, not a deep architectural analysis. If a reference exists, verify it exists in code. Do not analyze whether the description is nuanced enough.
- **Scope to what exists.** Only check files that actually exist in the project. If there is no MEMORY.md, skip the memory check. If there are no SKILL.md files, skip the skills check. Report what you can check, not what you cannot.
- **Suggest /guard for CLAUDE.md fixes.** Drift detection identifies the problem. `/guard` (if available) or manual editing fixes it. Keep the responsibilities separate.
- **Prioritize by impact.** A stale file path in CLAUDE.md that would send a developer to a nonexistent file is more urgent than a missing mention of a new utility function. Order the report by how likely the drift is to cause confusion.

## Steps

### Step 1: CLAUDE.md accuracy check

Read the project's `CLAUDE.md`. For every verifiable claim, check it against reality:

**File paths:** For every file path mentioned (in project structure, key files, etc.), verify the file exists at that path.
```bash
# For each path mentioned in CLAUDE.md
test -f <path> && echo "EXISTS" || echo "MISSING: <path>"
```

**Exported functions:** For every function name mentioned (in "Key exports" sections or similar), grep for its definition in the referenced file.
```bash
# For each function mentioned
grep -n "export.*function\|export const\|export type\|export interface" <file> | grep "<functionName>"
```

**Types and interfaces:** For every type mentioned, verify it still exists and its shape roughly matches the description (field names, not full signatures).

**Commands:** For every command mentioned (in "run locally" or similar sections), verify it is defined in `package.json` scripts or is a standard command.

**API routes:** For every route mentioned, verify the route file exists.

**Counts:** If CLAUDE.md says "8 stat categories" or "6 custom animations" or "13 items in the catalog," verify the count against the actual code.

**Tally results:**
```
CLAUDE.md: [X] references checked, [Y] valid, [Z] stale, [W] missing from docs
```

### Step 2: Memory file accuracy check

Find all memory files (typically in a Claude projects memory directory, or in-repo memory files):

```bash
find ~/.claude/projects/ -name "*.md" -path "*/memory/*" 2>/dev/null
find . -name "MEMORY.md" -o -name "memory.md" 2>/dev/null
```

For each memory file:
- If it references specific files, verify those files exist
- If it references specific functions or types, grep for them
- If it references PR numbers, verify via `gh pr view <number>` if gh CLI is available
- If it references specific features or behaviors, spot-check that the code still matches
- Flag entries that reference things that no longer exist

Do not deep-read every line of every memory file. Focus on concrete references (file paths, function names, PR numbers, feature names) that can be mechanically verified.

**Tally results:**
```
Memory files: [X] files scanned, [Y] references checked, [Z] stale
```

### Step 3: Skill accuracy check

Find all SKILL.md files:

```bash
find ~/.claude -name "SKILL.md" -type f 2>/dev/null
find . -path "*/.claude/skills/*/SKILL.md" 2>/dev/null
```

For each skill:
- If it references specific file paths, verify they exist
- If it references specific tools or MCP servers, check they are available
- If it references other skills by name, verify those skills exist
- If it references specific patterns or conventions, spot-check one example

**Tally results:**
```
Skills: [X] skills checked, [Y] have stale references
```

### Step 4: Project structure drift

If CLAUDE.md contains a project structure section (directory tree), compare it to reality:

```bash
# Get actual structure (top 3 levels, excluding node_modules, .git, etc.)
find . -maxdepth 3 -not -path '*/node_modules/*' -not -path '*/.git/*' -not -path '*/.next/*' -not -name '*.lock' | sort
```

Identify three categories:
1. **New (undocumented):** Files or directories that exist but are not in the documented tree
2. **Removed (still documented):** Files or directories in the documented tree that no longer exist
3. **Moved:** Files that exist at a different path than documented

Only report meaningful structural changes. Ignore files that would not typically be documented (lock files, build artifacts, editor configs).

### Step 5: Present drift report

Render the full report:

```
## Drift Report — [date]

### Summary
- **Overall health:** [ACCURATE / MINOR DRIFT / SIGNIFICANT DRIFT]
- **Total references checked:** [count]
- **Stale:** [count]
- **Missing from docs:** [count]

### CLAUDE.md ([X]% accurate)
#### Stale references
- Line [N]: References `path/to/file.ts` — file was moved to `path/to/newfile.ts`
- Line [N]: Lists export `functionName` — function was renamed to `newFunctionName` in `file.ts`
- ...

#### Missing from documentation
- `src/lib/newHelper.ts` — new file not mentioned in project structure
- `NewType` exported from `types.ts` — not listed in "Key exports" section
- ...

### Memory Files ([X]% accurate)
#### Stale entries
- `memory-file.md` line [N]: References PR #42 — PR was closed without merging
- ...

### Skills ([X]% accurate)
#### Stale references
- `/skillname` SKILL.md: References `tool-name` — tool no longer available
- ...

### Project Structure
#### New (undocumented)
- `src/app/newpage/` — new route not in structure tree
- ...

#### Removed (still documented)
- `src/components/OldComponent.tsx` — in structure tree but file was deleted
- ...

### Recommended actions (ordered by impact)
1. [Most impactful fix] — run `/guard` to update CLAUDE.md
2. [Next fix] — manually update memory file
3. ...
```

If the project is perfectly accurate, say so clearly and briefly. Do not pad the report.
