---
name: port
description: "Extract portable knowledge from a project into reusable kits. The skill that closes the flywheel."
---

# /port — Knowledge Extraction

You are a knowledge archaeologist. Your job is to look at a project's accumulated Claude Code infrastructure — skills, memory, hooks, settings, CLAUDE.md patterns — and separate what is portable from what is project-specific. Then you package the portable knowledge into reusable kits that can be installed in any future project.

This is the most architecturally important skill in the kit system. Without it, knowledge accumulates in one project and stays there. With it, every project makes every future project smarter.

## Philosophy

Every project is a teacher. Over weeks and months of development, you build up:
- Skills that encode your best workflows
- Memory files that capture hard-won lessons
- CLAUDE.md patterns that keep context accurate
- Hooks that enforce quality gates
- Settings that configure your environment

Most of this knowledge is locked inside one project's `.claude/` directory. But 60-70% of it would work anywhere. The challenge is separating the portable knowledge from the project-specific context — and doing it well enough that the portable version is genuinely useful, not a watered-down ghost of the original.

The key insight: **portability is not about removing specifics. It's about replacing specifics with detection.** A good portable skill doesn't say "run `npx vitest run`" — it says "detect the test runner and run it." A good portable memory template doesn't contain your project's design decisions — it contains the *structure* for capturing design decisions.

## Rules

- **Never delete source files.** Extraction copies and transforms — it never modifies the source project.
- **Err on the side of "project-specific."** If you're unsure whether something is portable, classify it as project-specific. A lean portable kit is better than a bloated one full of irrelevant context.
- **Preserve voice and philosophy.** When generalizing a skill, keep its personality. A portable `/delight` should still care about craft. A portable `/thesis` should still be opinionated. Stripping personality to achieve portability defeats the purpose.
- **Detection over hardcoding.** Replace project-specific commands with detection logic. Replace specific file paths with search patterns. Replace product names with generic language.
- **Memory templates, not memory data.** Extract the *structure* of memory files (sections, fields, format), not the *content*. The one exception: calibration profile data (user preferences) IS portable because it's about the person, not the project.
- **Ask before overwriting existing kits.** If `~/.claude/kits/[name]/` already exists, show a diff and confirm before replacing.
- **One extraction, clear report.** Gather everything, present the full picture, let the user decide what to package.

## Steps

### Step 1: Inventory the source project

Read everything in the project's Claude Code infrastructure:

**Skills:**
```bash
find .claude/skills -name "SKILL.md" -type f 2>/dev/null
```
For each skill, read the full SKILL.md and extract:
- Name and description
- What it does (1-2 sentences)
- Project-specific references (file paths, product names, feature names, specific tools)
- Dependencies on other skills
- Whether it uses parallel agents

**Memory files:**
Read all files in the project's memory directory. For each:
- What type of knowledge it contains (design taste, review history, instincts, catalog, etc.)
- How much is project-specific vs. structural
- Whether it contains calibration data (user preferences)

**CLAUDE.md:**
Read the project's CLAUDE.md. Identify:
- Sections that are project-specific (data model, specific types, visual design system for THIS product)
- Sections that are reusable patterns (decision framework, error handling conventions, visual verification loop, personality contracts)
- Working conventions that could apply to any project

**Hooks:**
```bash
find .claude/hooks -type f 2>/dev/null
```
For each hook: what it does, whether it's project-specific or generic.

**Settings:**
Read `.claude/settings.local.json` if it exists. Extract permission patterns and hook configurations.

### Step 2: Classify everything

For each piece of infrastructure, classify its portability:

**Universal** — Works in any project, any stack, any domain.
- Analytical skills with no code dependencies (thesis, devil, protocol, etc.)
- Session lifecycle skills (kickoff, wrapup, ship — with command detection)
- Meta-tooling skills (builder, subtractor, agent-zero)
- Learning engine skills (reflect, antipattern)
- Generic hooks (pre-push quality gate with package manager detection)
- Calibration data (user communication preferences, git conventions)

**Domain** — Works in projects with the same characteristics.
- Frontend-specific skills (delight with UI analysis, visual verification)
- AI personality skills (probe — only useful if the project has AI characters)
- Stack-specific patterns (Next.js conventions, Django patterns)
- Design tools integration (Canva/Figma skills — only if those tools are used)

**Project-specific** — Only works in this project.
- Skills that reference specific files, features, or data models
- Memory data (PR history, specific review findings, product instincts about THIS product)
- CLAUDE.md sections about THIS project's structure and types
- Debug utilities specific to this product (xp-debug, etc.)

Present the classification:

```
## Portability Analysis

### Universal (ready to extract)
- /ship — session lifecycle, needs command detection generalization
- /kickoff — session lifecycle, needs memory path generalization
- /thesis — pure analysis, no code dependencies
- /builder — pure analysis, reads skills and git
- [...]

### Domain-specific (extractable with context tag)
- /delight — requires frontend UI to analyze
- /probe — requires AI personalities to test
- /announce — requires Canva MCP
- [...]

### Project-specific (not portable)
- /xp-debug — injects debug button specific to this product
- /metrics — queries project-specific Supabase tables
- Memory: PR history, review findings
- CLAUDE.md: data model, visual design system colors
- [...]

### Calibration data (always portable)
- Design taste preferences (from design-taste.md)
- Communication style preferences (from calibration-profile.md or CLAUDE.md)
- Git/shipping preferences
```

### Step 3: Propose kit groupings

Based on the classification, propose how to organize the portable knowledge into kits. Use the standard kit taxonomy:

| Kit | Contents |
|-----|----------|
| `shipping-workflow` | Ship, kickoff, wrapup, guard, sweep, pulse + hooks + templates |
| `product-thinking` | Thesis, devil, protocol, persona, storyteller, stranger, observe |
| `craft-and-delight` | Delight, snapshot, recap, announce + design taste template |
| `meta-tooling` | Agent-zero, builder, subtractor, eli5, metrics + catalog template |
| `ai-personality` | Probe + personality contracts template |
| `learning-engine` | Reflect, antipattern + journal templates |
| `autopilot` | Autopilot, drift + scheduled tasks template |

If the source project has skills that don't fit these categories, propose a new kit or suggest where they belong.

If a kit already exists at `~/.claude/kits/[name]/`, compare the source project's versions against the existing kit versions and highlight differences. The user decides whether to update the kit.

Ask: "Which kits do you want to extract? (numbers, names, or 'all')"

### Step 4: Extract and generalize

For each confirmed kit, transform the source material into portable versions:

**Generalizing skills:**

1. Read the source SKILL.md
2. Identify every project-specific reference:
   - File paths (`src/lib/storage.ts` → "the main storage/data module")
   - Product names ("Dreamboard" → "[project]" or remove entirely)
   - Feature names ("Judge", "Skipper" → "AI characters", "the app's personality")
   - Specific tools ("Supabase" → "your database", "Vercel" → "your hosting platform")
   - Specific commands (`npx vitest run` → "detect and run the test suite")
3. Replace each reference with either:
   - **Detection logic** — "Read package.json to detect the test runner"
   - **Generic language** — "the project's main data model"
   - **Removal** — if the reference is truly project-specific and can't be generalized
4. Preserve:
   - The skill's philosophy/voice section
   - The parallel agent structure
   - The presentation template format
   - The rules section
   - The opinionated stance

**Generalizing memory templates:**

1. Read the source memory file
2. Keep the structure (sections, fields, formatting)
3. Replace filled-in content with template placeholders: `[TBD — learn from first few sessions]`
4. Exception: calibration data that describes the USER (not the project) should be preserved in calibration-profile.md

**Extracting CLAUDE.md fragments:**

1. Read the source CLAUDE.md
2. Identify reusable sections (these are patterns, not data):
   - Decision frameworks
   - Visual verification loops
   - Error handling conventions
   - AI personality management patterns
   - Working conventions that reference process, not product
3. Extract each as a standalone fragment that can be appended to any CLAUDE.md

**Generalizing hooks:**

1. Read the source hook script
2. Replace hardcoded commands with detection (package manager, test runner, linter)
3. Keep the structure and error handling

### Step 5: Write to kit directory

For each kit being extracted:

1. Check if `~/.claude/kits/[kit-name]/` exists
   - If yes: show what's different, ask before overwriting
   - If no: create the directory structure

2. Write all files:
   - `README.md` — kit overview
   - `skills/[name]/SKILL.md` — each generalized skill
   - `hooks/[name]` — generalized hooks (if any)
   - `memory-templates/[name].md` — generalized memory templates (if any)
   - `templates/[name]` — CI, launch.json, flight manifest templates (if any)
   - `claude-md-fragment.md` — extracted CLAUDE.md section

### Step 6: Present the extraction report

```
## Port Report — [date]

### Source project
[Project name] — [brief description]
[X] skills, [Y] memory files, [Z] hooks analyzed

### Extracted
| Kit | Skills | Templates | Hooks | Fragment |
|-----|--------|-----------|-------|----------|
| shipping-workflow | 6 | 3 | 1 | yes |
| product-thinking | 7 | 0 | 0 | yes |
| [...]

### Left behind (project-specific)
- /xp-debug — product-specific debug tool
- /metrics — queries project-specific database schema
- Memory: [X] files of project-specific data
- CLAUDE.md: data model, visual design, [X] project-specific sections

### Calibration data preserved
- [X] design taste preferences → craft-and-delight kit
- [X] communication preferences → learning-engine calibration profile

### Kit status
| Kit | Status |
|-----|--------|
| shipping-workflow | NEW — created from scratch |
| product-thinking | UPDATED — 2 skills improved vs existing kit |
| meta-tooling | UNCHANGED — existing kit was already current |
| [...]

### Recommended next steps
1. Review the extracted kits at ~/.claude/kits/
2. Test in a new project: run /bootstrap → /install-kit
3. After first session in new project, run /reflect to start the learning engine
```

## What makes a good extraction

The quality bar for extracted skills is: **would this skill be useful and coherent if you'd never seen the source project?**

A skill that says "check the Judge's personality for voice drift" is project-specific.
A skill that says "identify each AI personality in the codebase, build a behavioral contract from its system prompt, then test adversarial scenarios against the contract" is portable.

The difference is: one references a specific character. The other describes a process that works for any AI character.

Apply this test to every file you extract: could someone use this effectively without knowing anything about the source project? If yes, it's portable. If no, it needs more generalization — or it's genuinely project-specific and should be left behind.
