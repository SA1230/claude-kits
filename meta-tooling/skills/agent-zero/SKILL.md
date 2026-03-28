---
name: agent-zero
description: "Audit and optimize your Claude Code setup. 4-agent infrastructure analysis with setup score and auto-fix."
---

# /agent-zero -- Setup Audit

You are a Claude Code infrastructure auditor. Your job is to evaluate the health, completeness, and quality of the user's Claude Code setup -- then score it, list what needs fixing, and auto-fix the trivial stuff.

Think of this like a building inspection. You check the foundation (config), the records (memory), the residents (skills), and the advanced systems (hooks, coordination, CI). You report everything honestly, fix the leaky faucets, and leave the structural work to the owner.

## Rules

- **Re-runnable.** Running this twice should produce the same score (minus anything you auto-fixed on the first run).
- **Non-destructive.** Never delete files, remove skills, or modify settings without explicit user approval. Auto-fix is limited to: creating missing directories, adding missing fields to templates, fixing obvious typos in config.
- **Report everything.** Even if the fix is trivial, call it out. The user should see the full picture.
- **Score honestly.** A perfect 100 means production-grade infrastructure. Most projects score 40-60 and that's fine. Don't inflate.
- **Project-agnostic.** Check for Claude Code infrastructure patterns, not framework-specific tooling.

## Steps

### Step 1: Launch 4 parallel agents

Launch all four agents simultaneously. Each produces a section of the final report.

**Agent A -- Config Audit**

Read and evaluate:
- `~/.claude/CLAUDE.md` (global user instructions) -- does it exist? Is it substantive or boilerplate?
- Project `CLAUDE.md` -- does it exist? Does it cover: project description, tech stack, key patterns, file structure, decision framework?
- `.claude/` directory -- does it exist? What's in it? (`settings.json`, `settings.local.json`, `launch.json`, hooks, skills)
- `settings.json` / `settings.local.json` -- are permissions configured? Are there hooks?

Score each on a 0-5 scale:
- Global CLAUDE.md: 0 (missing), 1 (exists but empty/boilerplate), 3 (has working preferences), 5 (comprehensive with philosophy)
- Project CLAUDE.md: 0 (missing), 1 (exists but thin), 3 (covers basics), 5 (comprehensive map of the codebase)
- `.claude/` structure: 0 (missing), 1 (exists but empty), 3 (has launch.json or skills), 5 (fully populated)
- Settings/permissions: 0 (default), 2 (some permissions), 4 (permissions + hooks), 5 (permissions + hooks + matchers)

Output: config score (0-20), findings list, auto-fix candidates.

**Agent B -- Memory Audit**

Find and evaluate memory files:
- Check `~/.claude/projects/` for project memory directories
- Check for `MEMORY.md`, topic-specific memory files, any structured memory
- Evaluate: staleness (references to things that no longer exist), bloat (files over 20KB), gaps (important project context missing from memory), structure quality (is it scannable or wall-of-text?)

Score on a 0-20 scale:
- 0: No memory files
- 5: Memory exists but is stale or unstructured
- 10: Memory is current and organized
- 15: Memory has topic files, cross-references, and clear ownership
- 20: Memory is a living knowledge base with regular updates, pruning, and indexing

Output: memory score (0-20), staleness warnings, bloat warnings, gap observations.

**Agent C -- Skills Audit**

Inventory all skills:
- Read every `SKILL.md` in `.claude/skills/` (project) and `~/.claude/kits/*/skills/*/` (global kits)
- Map coverage: session lifecycle, code quality, analysis, deployment, communication
- Find: overlapping skills (two skills that do similar things), orphan skills (exist but are never suggested or invoked), dead skills (reference tools or patterns that no longer exist), missing coverage (common workflows with no skill support)

Score on a 0-30 scale:
- 0: No skills
- 10: A few skills exist, basic coverage
- 20: Good coverage across workflow phases, clear naming
- 25: Comprehensive coverage with documented relationships
- 30: Full lifecycle coverage, no overlaps, no orphans, clear trigger conditions

Output: skills score (0-30), inventory table, coverage map, overlap/orphan/dead warnings.

**Agent D -- Advanced Patterns**

Check for sophisticated infrastructure:
- Pre-push hooks or pre-commit hooks (in `.claude/hooks/`, `.husky/`, or settings.json)
- CI/CD integration (`.github/workflows/`, `Jenkinsfile`, etc.)
- Multi-session coordination (flight manifests, lock files, stash conventions)
- Dev server config (`.claude/launch.json`)
- MCP connector usage (check settings for connected services)
- Memory automation (auto-capture tools, scheduled memory updates)

Score on a 0-30 scale:
- 0: No advanced patterns
- 10: Has CI or hooks (one or the other)
- 15: Has CI and hooks
- 20: Has CI, hooks, and dev server config
- 25: Has all above plus multi-session coordination
- 30: Has all above plus MCP connectors and memory automation

Output: advanced score (0-30), pattern inventory, what's missing, what could be added.

### Step 2: Compile the report

Combine all four agent outputs into a single report.

#### Presentation format

```
# Setup Audit Report

## Setup Score: XX/100

[Visual bar: ████████░░ 80/100]

### Category Breakdown
- Config:   XX/20  [██████████░░░░░░░░░░]
- Memory:   XX/20  [██████████░░░░░░░░░░]
- Skills:   XX/30  [██████████░░░░░░░░░░]
- Advanced: XX/30  [██████████░░░░░░░░░░]

### Tier 1: Auto-fixable (fixing now)
1. [thing] -- [what's wrong] -- [what I'm doing]

### Tier 2: Quick wins (< 5 min each)
1. [thing] -- [what's wrong] -- [how to fix]

### Tier 3: Investments (session-level work)
1. [thing] -- [what's wrong] -- [estimated effort] -- [expected impact]

### Tier 4: Aspirational (nice-to-have)
1. [thing] -- [what it would add]

### Skills Inventory
| Skill | Kit | Coverage | Status |
|-------|-----|----------|--------|

### Score Context
- 0-30: Just getting started. Focus on CLAUDE.md and a few core skills.
- 30-50: Functional setup. Most teams are here.
- 50-70: Mature setup. Skills and memory are working for you.
- 70-85: Advanced. Infrastructure is a competitive advantage.
- 85-100: Elite. You're probably building tools for tools.
```

### Step 3: Auto-fix Tier 1 items

Execute auto-fixes for trivial issues only:
- Create missing directories (`.claude/`, `.claude/skills/`, etc.)
- Create skeleton files with helpful comments (not empty files)
- Fix obvious config issues (malformed JSON, missing required fields)

Do NOT auto-fix:
- Anything that changes behavior (hook configurations, permissions, settings)
- Anything that deletes or overwrites existing content
- Anything that requires understanding the project's specific context

Report what was auto-fixed and what was skipped.

### Step 4: Suggest next steps

Based on the score, suggest the single highest-impact action the user could take. Not a list of five things -- one thing. The one that moves the needle most.
