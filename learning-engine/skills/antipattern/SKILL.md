---
name: antipattern
description: Active pattern matching against known failures — the immune system that prevents repeat mistakes
triggers:
  - /antipattern
  - before risky operations
  - when editing files with known failure history
---

# /antipattern — Failure Prevention

A failure journal that nobody reads is a filing cabinet. An antipattern detector that fires at the right moment is an immune system. The difference is timing.

## Philosophy

This skill is PREVENTIVE. It runs before risky operations, not after failures. It scans current work against the failure journal and surfaces warnings when trigger conditions match. It doesn't block — it informs. False positives are better than missed warnings.

Speed matters. This should take seconds, not minutes. Scan, match, report.

## Steps

### 1. Gather current context

Determine what's happening right now:

```
git diff --name-only          # What files are being changed?
git diff --stat               # How big are the changes?
git diff                      # What do the changes look like?
```

Identify the operation type from the context:
- Type/interface change (widening, narrowing, adding fields)
- Storage/persistence change (new table, migration, storage layer)
- Auth/identity change (providers, sessions, tokens)
- Toggle/setting addition (new feature flag, user preference)
- Dependency change (new package, version bump)
- API change (new endpoint, changed contract)
- UI state change (new context, prop drilling, state management)
- Data migration (schema change, backfill, format change)

### 2. Read the failure journal

Look for the failure journal in the project's memory directory. Common locations:
- `~/.claude/projects/*/memory/failure-journal.md`
- Project root memory files

If no failure journal exists, report clean and suggest running `/reflect` after the next session to start building the immune system.

### 3. Match trigger conditions

For each entry in the failure journal, check if any trigger conditions match:

**File-based triggers:**
- Is the current file mentioned in a past failure?
- Is a file in the same module/directory mentioned?

**Pattern-based triggers:**
- Does the diff contain a pattern that caused a past failure?
- Union type being widened to string?
- New toggle/setting being added?
- Auth configuration being modified?
- Storage write path being changed?

**Operation-based triggers:**
- Is the operation type the same as a past failure?
- Type widening without consumer audit?
- Toggle addition without calculation path check?
- Auth change without identity chain trace?
- Storage migration without write bottleneck check?
- Dependency addition without bundle size check?

**Structural triggers:**
- Adding a feature that mirrors a pattern where a past failure occurred?
- Touching a system (habits, damage, inventory, sync) that had issues before?

### 4. Score match confidence

For each match, assess confidence:
- **High** — Same file, same operation type, same pattern as the past failure
- **Medium** — Same operation type and similar pattern, different file
- **Low** — Same broad category but different specifics

Only surface Medium and High matches. Low matches create noise.

### 5. Report findings

## Output Format

If matches found:

```
## Antipattern Check

**Context:** Editing [file(s)] — [operation type]

**Matches found: [count]**

1. **[Past failure title]** (from [date])
   - Trigger: [what matched — be specific]
   - Last time: [what went wrong, one sentence]
   - Check now: [specific verification step to take]
   - Confidence: [High/Medium]

2. ...

**Recommended verification steps:**
- [ ] [Concrete check #1]
- [ ] [Concrete check #2]
```

If no matches:

```
## Antipattern Check

**Context:** Editing [file(s)] — [operation type]

No matching failure patterns found. Proceeding clean.

Failure journal entries scanned: [count]
```

## Built-in Trigger Patterns

Even without a failure journal, these universal patterns are always checked:

### Type Widening
**Trigger:** A union type is being changed to `string` or a type parameter is being broadened.
**Risk:** Every consumer of that type needs updating — not just the data layer.
**Check:** Grep for all imports/uses of the changed type. Count the files. If more than 3, plan the full ripple.

### Toggle Addition
**Trigger:** A new boolean setting, feature flag, or enable/disable control is being added.
**Risk:** UI hides the feature, but calculations/side effects may still include it.
**Check:** Trace every code path that reads the data the toggle controls. Ensure all paths filter by the toggle state.

### Auth Changes
**Trigger:** Authentication provider, session strategy, or identity fields are being modified.
**Risk:** Dev auth bypass may not mirror the full production identity chain.
**Check:** Trace the auth chain end-to-end: provider -> callback -> session -> every downstream consumer that checks identity.

### Storage Migration
**Trigger:** Storage layer is being added, changed, or migrated (localStorage -> server, new DB table, schema change).
**Risk:** Missing the single write bottleneck that all mutations funnel through.
**Check:** Find the single write function. Verify the migration hooks into it, not around it.

### Dependency Addition
**Trigger:** A new npm/pip/cargo package is being added.
**Risk:** Bundle size, security, maintenance burden.
**Check:** Check bundle size impact. Check last publish date. Check if the functionality can be achieved with existing dependencies.

### Idempotency Gaps
**Trigger:** A function that runs on mount, on event, or on schedule is being added/modified.
**Risk:** Running twice produces different results, duplicate entries, or side effects.
**Check:** Call the function twice with the same input. Verify the output is identical both times.

## Rules

1. **Speed over depth.** This is a scan, not an investigation. 30 seconds, not 5 minutes. Surface the warning and move on.

2. **Never block work.** Warnings are informational. The developer decides whether to act on them. Never refuse to proceed based on a match.

3. **False positives are acceptable.** Missing a real match is worse than surfacing a false one. Err on the side of warning.

4. **Be specific in verification steps.** "Be careful" is useless. "Grep for all imports of HabitKey and verify each file handles string keys" is actionable.

5. **Built-in patterns always run.** Even if the failure journal is empty, the universal trigger patterns above should be checked against the current diff.

6. **Don't editorialize.** Report what matched and what to check. Don't lecture about why the past failure happened — the journal entry already has that context.

7. **Suggest /reflect if no journal exists.** If there's no failure journal yet, this skill's value is limited. Flag it and move on.
