# Claude Code Kits

Portable bundles of skills, patterns, and institutional knowledge that compound across projects.

## The problem

You build a project. Over weeks, Claude Code accumulates skills, memory, hooks, patterns, and hard-won lessons. Then you start a new project — and all of it stays behind. You start from zero. Again.

60-70% of what you built is portable. Analytical skills. Shipping pipelines. Quality gates. Decision frameworks. Design taste. Failure patterns. But there's no clean way to separate the portable knowledge from the project-specific context, and no way to install it somewhere new.

Kits solve this.

## The flywheel

```
Build (in a project)
  → Extract (/port — separate portable from project-specific)
  → Store (~/.claude/kits/ — organized, generalized bundles)
  → Install (/bootstrap + /install-kit — bring kits into new projects)
  → Adapt (first sessions — kits calibrate to new context)
  → Improve (/reflect — kits get smarter with each project)
  → Build...
```

Every project makes the next project better. The kits compound.

## The 8 kits

### Foundation (install in every project)

| Kit | Purpose | Skills |
|-----|---------|--------|
| **shipping-workflow** | Build → verify → commit → deploy → monitor | /ship, /kickoff, /wrapup, /guard, /sweep, /pulse |
| **learning-engine** | Never make the same mistake twice | /reflect, /antipattern |
| **cold-start-killer** | Never start from zero | /ignition, /bootstrap, /scaffold, /install-kit, /port |

### Product (install for products with users)

| Kit | Purpose | Skills |
|-----|---------|--------|
| **product-thinking** | Structured decisions about what to build | /thesis, /devil, /protocol, /persona, /storyteller, /stranger, /observe |
| **craft-and-delight** | Make it feel good, not just work | /delight, /snapshot, /recap, /announce |

### Specialized (install when relevant)

| Kit | Purpose | Skills |
|-----|---------|--------|
| **meta-tooling** | Agents that improve other agents | /agent-zero, /builder, /subtractor, /eli5, /metrics |
| **ai-personality** | For products with AI characters | /probe |
| **autopilot** | Background quality maintenance | /autopilot, /drift |

## How kits connect

```
Session start:
  /kickoff → reads memory, checks state, presents briefing

During work:
  /antipattern → fires before risky edits (from learning-engine)
  /thesis → stress-tests ideas (from product-thinking)
  /delight → finds moments of craft (from craft-and-delight)

Shipping:
  /guard → checks docs accuracy (from shipping-workflow)
  /ship → lint, build, test, self-review, commit, PR, merge (from shipping-workflow)
  /pulse → post-deploy health check (from shipping-workflow)

Session end:
  /reflect → extracts lessons (from learning-engine)
  /wrapup → cleans up, updates memory (from shipping-workflow)

Between sessions:
  /drift → detects doc rot (from autopilot)
  /sweep → prunes stale branches and memory (from shipping-workflow)
  /autopilot → runs scheduled quality checks (from autopilot)

New project:
  /bootstrap → detects stack, generates CLAUDE.md (from cold-start-killer)
  /scaffold → spins up Vercel, Supabase, auth, Sentry, CI (from cold-start-killer)
  /install-kit → installs relevant kits (from cold-start-killer)

Extracting knowledge:
  /port → packages portable skills into kits (from cold-start-killer)
```

## Quick start

### Starting a new project (one command)

```
cd ~/my-new-project
```

Then in Claude Code:
```
/ignition
```

That's it. One command chains: detect stack → generate CLAUDE.md → wire up Vercel/Supabase/auth/Sentry/tests/CI → install skill kits → verify everything works. Three lightweight checkpoints where you confirm or correct. 15 minutes from empty repo to production-ready.

Or run each phase individually:
```
/bootstrap     — detect stack, generate CLAUDE.md, set up workspace
/scaffold      — wire up Vercel, Supabase, auth, Sentry, tests, CI
/install-kit   — install the kits you want
/kickoff       — verify everything works
```

### Extracting from an existing project

```
cd ~/my-mature-project
```

Then in Claude Code:
```
/port          — analyze project, classify knowledge, extract kits
```

### Installing kits manually

```
/install-kit   — shows available kits, installs selected ones
```

## Kit anatomy

Each kit is a directory under `~/.claude/kits/` with this structure:

```
kit-name/
├── README.md              — What this kit does, what it contains
├── skills/
│   ├── skill-a/SKILL.md   — Portable skill file
│   └── skill-b/SKILL.md
├── hooks/                  — Shell scripts (pre-push, etc.)
├── templates/              — Config files (CI, launch.json, etc.)
├── memory-templates/       — Memory file structures (not data)
└── claude-md-fragment.md   — CLAUDE.md section to append
```

**Skills** are the core — they encode workflows, analysis patterns, and quality processes.
**Hooks** are shell scripts that enforce quality gates.
**Templates** are starter files for CI, dev servers, and coordination.
**Memory templates** are empty structures — the data comes from working in the project.
**CLAUDE.md fragments** are reusable documentation sections.

## Design principles

**Skills are the wrong unit of portability. Kits are.** A single skill in isolation loses most of its value. /ship is powerful because /guard runs before it and /pulse runs after it. They're a system. Kits preserve the relationships.

**Detection over hardcoding.** Portable skills don't say "run vitest" — they detect the test runner and run it. They don't reference specific files — they search for patterns. This makes them work in any project without modification.

**Preserve voice, generalize references.** When extracting a skill from a project, keep its personality (the opinionated philosophy, the strong voice). Strip the project-specific references (file paths, product names, specific tools). A portable /delight should still care deeply about craft — it just shouldn't reference "Skipper" or "the Judge."

**Memory templates, not memory data.** Kits carry the structure for capturing knowledge, not the knowledge itself. The calibration profile template has sections for preferences — but the preferences come from working with you. The one exception: user preferences (communication style, git conventions) ARE portable because they describe the person, not the project.

**The flywheel is the product.** No single kit is the point. The compounding loop — build, extract, store, install, adapt, improve — is the point. Every piece of the system should make the loop turn faster.

## What 10x actually looks like

| Without kits | With kits |
|-------------|-----------|
| Every new project starts from zero | Session 1 feels like session 10 |
| Lessons stay in one project | Lessons compound across all projects |
| Quality gates are set up "later" | Infrastructure on day one |
| Same mistakes repeat across projects | Failure journal prevents repeats |
| Skills are rebuilt from scratch | Skills travel and improve |
| Documentation rots silently | Drift detection catches rot |

The 10x isn't about speed. It's about a rising floor. Project 1 you're 3x. Project 5 you're 10x. Project 10 you're something else entirely — because the kits have absorbed 10 projects worth of failures, taste decisions, and patterns.

## Maintaining kits

**Update a kit:** Edit the files in `~/.claude/kits/[name]/` directly. Next time you run `/install-kit` in a new project, it uses the latest version. Existing projects keep their copy.

**Extract improved versions:** If a skill evolved significantly in a project, run `/port` to extract the improved version back to the kit.

**Retire a kit:** Delete the directory. Existing projects keep their installed copies.

**Add a new skill to a kit:** Create the SKILL.md in the kit's `skills/` directory. It will be available next time `/install-kit` runs.

---

*Built from the accumulated patterns of 200+ shipped PRs across real products. Every skill was battle-tested before being generalized.*
