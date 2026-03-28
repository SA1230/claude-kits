---
name: reflect
description: Post-session lesson extraction — capture the invisible learning before it evaporates
triggers:
  - /reflect
  - end of session
  - after significant failures
---

# /reflect — Lesson Extraction

Most sessions produce two things: shipped code and invisible learning. The code gets committed. The learning gets forgotten. This skill captures the learning before it evaporates.

## Philosophy

The bar for saving a lesson is SURPRISE. If it wasn't surprising, it doesn't compound. "We wrote tests" is not a lesson. "Tests passed but the feature was broken because tests didn't cover the integration path" IS a lesson. Quality over quantity — 2 good lessons beat 10 obvious ones.

## Steps

### 1. Review the session's work

Gather evidence of what happened this session:

```
git log --oneline -20
git diff --stat HEAD~5..HEAD (adjust range to session)
```

Look at: commits made, files changed, errors encountered, pivots taken, decisions debated. If a `/wrapup` already ran, read its output for context.

### 2. Identify significant moments

For each decision, surprise, failure, or pivot, ask three questions:

1. **Was this project-specific or would it apply anywhere?** Project-specific lessons go to project memory. Universal lessons go to the instincts journal.
2. **Was this surprising?** If the answer was obvious beforehand, skip it. Only surprising outcomes compound.
3. **Would knowing this have saved time if I'd known it at session start?** If yes, it's worth capturing. If no, it's trivia.

### 3. Classify each lesson

- **Instinct** — A product/design judgment confirmed or disproven. Example: "disabled features must have zero mechanical effect"
- **Pattern** — A technical approach that worked or failed. Example: "type widening requires touching every consumer, not just the data layer"
- **Calibration** — A preference or taste data point about the developer/founder. Example: "prefers one bundled PR over many small ones for refactors"
- **Trap** — Something that looked right but was wrong. Example: "dev auth must mirror the full production identity chain, not just bypass login"

### 4. Write each lesson in structured format

For each lesson:

- **The lesson** — One sentence, imperative voice. Should be actionable on its own.
- **Why** — What happened that taught this. Specific to this session.
- **How to apply** — When and where this fires in future work. Be concrete.
- **Scope** — `universal` (any project), `tech-stack` (e.g., Next.js + Supabase), or `project` (this repo only)

For traps specifically, also write:

- **Trigger condition** — The specific situation where this trap appears (file patterns, operation types, code patterns). Must be concrete enough for `/antipattern` to match against.
- **Prevention** — What to do instead.
- **Verification** — How to confirm you didn't fall in.

### 5. Save to the right locations

Read the existing memory files first. Do not duplicate entries that already exist.

**Universal + tech-stack lessons** --> `instincts-journal.md` in the project's memory directory (create from template if it doesn't exist)

**Traps** --> `failure-journal.md` in the project's memory directory (create from template if it doesn't exist)

**Calibration data points** --> `calibration-profile.md` in the project's memory directory (create from template if it doesn't exist)

**Project-specific lessons** --> Project's main memory file (MEMORY.md or equivalent)

### 6. Present the summary

## Output Format

```
## Reflection — [date]

### Lessons extracted: [count]

**Instincts (universal)**
- [lesson] — Why: [context] — Apply: [when]

**Patterns (tech-stack)**
- [lesson] — Why: [context] — Apply: [when]

**Calibrations (preferences)**
- [lesson] — Why: [context] — Apply: [when]

**Traps (failure prevention)**
- [trap] — Trigger: [when this pattern appears] — Instead: [what to do]

### Saved to:
- instincts-journal.md: [count] entries added
- failure-journal.md: [count] entries added
- calibration-profile.md: [count] data points added
- project memory: [count] entries added
```

## Rules

1. **Surprise is the filter.** If the outcome was predictable, don't save it. The journal should be full of "I didn't expect that" moments, not "I did the thing and it worked."

2. **One sentence per lesson.** The lesson statement must stand alone. If you need a paragraph to explain it, you haven't distilled it enough.

3. **Concrete trigger conditions on traps.** "Be careful with auth" is useless. "When adding a dev auth bypass, trace the full identity chain — JWT callbacks, signIn events, and profile upserts all need fallbacks" is actionable.

4. **Don't duplicate.** Read existing journal entries before adding new ones. If a lesson is already captured, skip it or update the existing entry with new evidence.

5. **Instincts need verdicts.** Every instinct must be tagged CONFIRMED, DISPROVEN, or OPEN. Don't save vague hypotheses — save tested beliefs.

6. **Calibrations are observations, not judgments.** "Founder prefers X over Y" not "X is better than Y." Preferences are facts about the person, not universal truths.

7. **2 good lessons beat 10 obvious ones.** If a session was routine with no surprises, it's fine to report "No significant lessons this session." Don't force it.
