---
name: ignition
description: "One command to go from empty project to fully operational. Chains bootstrap → scaffold → install-kit → kickoff with smart checkpoints."
---

# /ignition — Turn the Key

One command. That's it. You run `/ignition` in a new project and walk away with:
- A generated CLAUDE.md that understands your codebase
- Vercel deployed, Supabase connected, auth configured, Sentry tracking, tests passing, CI running
- Your best skills installed and ready
- A session briefing telling you what to build first

No setup days. No "I'll configure that later." No cold start.

## Philosophy

The setup tax is real. Every hour spent wiring infrastructure is an hour not spent building the thing that matters. Most developers spread this tax across their first 2 weeks — a little CI here, some auth there, Sentry "when we get to it." By the time everything is wired, the momentum is gone.

`/ignition` compresses all of that into one pass. It runs the four cold-start-killer skills in sequence, pausing only at genuine decision points. Everything that can be automated is automated. Everything that needs your input gets asked once, upfront, in a batch.

## How it works

```
/ignition
    │
    ├── Phase 1: DETECT (/bootstrap)
    │   Read manifest, directory, git, tooling → generate CLAUDE.md draft
    │   ⏸ CHECKPOINT: "Here's what I detected. Corrections?"
    │
    ├── Phase 2: BUILD (/scaffold)
    │   Wire hosting, database, auth, errors, tests, CI
    │   ⏸ CHECKPOINT: "Which services? (defaults recommended)"
    │
    ├── Phase 3: EQUIP (/install-kit)
    │   Install relevant skill kits
    │   ⏸ CHECKPOINT: "These kits match your project. All good?"
    │
    └── Phase 4: VERIFY (/kickoff)
        Sync, build, test, present briefing
        ✅ DONE: "Ready to build."
```

Four phases. Three lightweight checkpoints. One command.

## Effort

This skill does foundational work that affects the entire project lifetime. If the session is on medium effort, say: "This is a foundational setup — I'd recommend switching to high effort with `/effort` for the best results." Proceed either way, but the suggestion matters.

## Empty Folder Path

If all detection probes return nothing (no manifest, no source files, no git history beyond init), do NOT try to generate a CLAUDE.md from thin air. Instead:

1. Ask ONE question: **"What are you building?"** — accept a sentence, a paragraph, or a reference to another repo/URL.
2. If they reference another repo (local path or GitHub URL), read that repo's README, manifest, and key files to understand the architecture. Then propose what to build in THIS repo based on what you learned.
3. If they describe it in words, propose a stack and architecture, then ask for confirmation.
4. Once you have clarity, scaffold the project (create package.json, src/, tsconfig, etc.) BEFORE running Phase 1 detection again. Now detection has something to work with.
5. Then continue with Phase 2-4 as normal.

This path should feel conversational, not procedural. One smart question, one proposal, then build.

## Steps

### Phase 1: Detect

Run the `/bootstrap` skill's detection probes (all parallel):
- Probe A: Manifest and dependencies
- Probe B: Directory structure
- Probe C: Existing documentation
- Probe D: Git history and conventions
- Probe E: Tooling and infrastructure
- User-level config: Read ~/.claude/CLAUDE.md for global preferences
- MCP tools: Detect available connectors (Vercel, Supabase, Slack, etc.)

Generate:
- CLAUDE.md draft
- .claude/launch.json (if missing)
- .claude/settings.local.json (if missing)
- Memory directory scaffolding

**CHECKPOINT 1 — Detection Review**

Present a compact summary. Not the full CLAUDE.md — just the key decisions:

```
## Phase 1: Detection Complete

Detected: [Framework] + [Language] + [Database] + [Hosting]
CLAUDE.md: Generated ([X] lines) — saved as draft

Key assumptions (correct me if wrong):
  Stack: Next.js 15 / TypeScript / Tailwind / Supabase / Vercel
  Dev server: npm run dev (port 3000)
  Test runner: Vitest
  Package manager: npm

MCP tools available: Vercel ✅  Supabase ✅  Slack ✅  GitHub ✅

Anything wrong? (Enter to continue, or type corrections)
```

If the user presses enter or says "looks good" — proceed. If they correct something — update and proceed. Don't wait for perfection — CLAUDE.md is a living document.

### Phase 2: Build

Based on detection results, determine which infrastructure to set up. Present the plan as a checklist with sensible defaults:

```
## Phase 2: Infrastructure

Recommended setup (all free tier):
  [x] Hosting — Vercel (MCP connected, will create project)
  [x] Database — Supabase (MCP connected, will create project)
  [x] Auth — NextAuth + Google OAuth (detected in code)
  [x] Error tracking — Sentry (not installed, will add)
  [x] Testing — Vitest (installed, will write first test)
  [x] CI — GitHub Actions (will create workflow)
  [x] Pre-push hook — quality gate (will install)

Uncheck anything you want to skip. (Enter to proceed with all)
```

Then run `/scaffold` for the confirmed services. Key behaviors:

**Services that need user action:** Batch all "you need to do this" items together instead of stopping for each one:
```
Before I can finish, you'll need to:
1. Set GOOGLE_CLIENT_ID and GOOGLE_CLIENT_SECRET in .env.local
   → Get from: https://console.cloud.google.com/apis/credentials
2. Set SENTRY_DSN in .env.local
   → Get from: Sentry project settings after creation
3. Set these same vars in Vercel dashboard
   → Link: [vercel project settings URL]

Do these now, or I'll continue with what I can and you fill them in later.
```

**Services that can be fully automated:** Just do them. Create the Supabase project (with cost confirmation), configure CI, install the pre-push hook, write the first test. No checkpoint needed for each one.

**End of Phase 2:**
Run the validation health check. Report what's green and what needs manual completion.

### Phase 3: Equip

Determine which kits are relevant (same logic as `/bootstrap` step 5):

| Kit | Install when |
|-----|-------------|
| shipping-workflow | Always |
| learning-engine | Always |
| product-thinking | Has UI / has users |
| craft-and-delight | Has frontend code |
| meta-tooling | Already has 5+ skills |
| ai-personality | Has AI/LLM API calls |
| autopilot | Has CI + hosting tools |

Present as a pre-checked list:

```
## Phase 3: Kit Installation

Installing:
  [x] shipping-workflow — 6 skills (ship, kickoff, wrapup, guard, sweep, pulse)
  [x] learning-engine — 2 skills (reflect, antipattern) + memory templates
  [x] product-thinking — 7 skills (thesis, devil, protocol, persona, storyteller, stranger, observe)
  [x] craft-and-delight — 4 skills (delight, snapshot, recap, announce)
  [ ] meta-tooling — not enough existing skills yet
  [ ] ai-personality — no AI calls detected
  [x] autopilot — 2 skills (autopilot, drift)

Adjust? (Enter to install all checked)
```

Then install the confirmed kits using direct file copies. **Do NOT spawn subagents for installation — agents hit permission walls.** Instead:

For each confirmed kit, run these Bash commands directly:
```bash
# Copy all skills from the kit
for skill_dir in ~/.claude/kits/<kit-name>/skills/*/; do
  skill=$(basename "$skill_dir")
  mkdir -p .claude/skills/$skill
  cp "$skill_dir/SKILL.md" .claude/skills/$skill/SKILL.md
done

# Copy hooks (if any)
if [ -d ~/.claude/kits/<kit-name>/hooks ]; then
  mkdir -p .claude/hooks
  cp ~/.claude/kits/<kit-name>/hooks/* .claude/hooks/
  chmod +x .claude/hooks/*
fi

# Copy memory templates (if any)
if [ -d ~/.claude/kits/<kit-name>/memory-templates ]; then
  # Detect or create the project memory directory
  mem_dir=$(find ~/.claude/projects -type d -name memory -path "*$(basename $(pwd))*" 2>/dev/null | head -1)
  if [ -n "$mem_dir" ]; then
    cp -n ~/.claude/kits/<kit-name>/memory-templates/* "$mem_dir/"
  fi
fi
```

Then read each kit's `claude-md-fragment.md` and append to CLAUDE.md (check for duplicate sections first).

### Phase 4: Verify

Run `/kickoff` to validate the full setup:
- Sync main
- Read the just-created memory
- Check project state (build, tests, CI)
- Present the session briefing

But extend it with infrastructure verification:

```
## Phase 4: Ready to Build

### Workspace
  Branch: main (clean)
  Build: ✅ passing
  Tests: ✅ 1 passing
  CI: ✅ workflow created

### Infrastructure
  Hosting: ✅ Vercel — [url]
  Database: ✅ Supabase — [region]
  Auth: ⚠️ needs OAuth credentials (listed above)
  Errors: ✅ Sentry configured
  Quality gate: ✅ pre-push hook active

### Skills installed: [count]
  /ship, /kickoff, /wrapup, /guard, /sweep, /pulse
  /reflect, /antipattern
  /thesis, /devil, /protocol, /persona, /storyteller, /stranger, /observe
  /delight, /snapshot, /recap, /announce
  /autopilot, /drift

### Still needs your input
  1. Google OAuth credentials → .env.local + Vercel
  2. [anything else that couldn't be automated]

### Ready for: [suggested first task based on what exists]

Total setup time: [elapsed time]
```

## Rules

- **One command, three checkpoints, zero busywork.** Every checkpoint is a quick confirmation, not a form to fill out. The user should be able to hit Enter through all three if the defaults are right.
- **Batch human actions.** Don't stop for each API key separately. Collect everything the user needs to do manually and present it once, as a numbered list.
- **Fail forward.** If Sentry setup fails, note it and continue. If Supabase creation times out, note it and continue. Infrastructure gaps are reported at the end, not blocking.
- **Smart defaults.** Free tier everything. Install the kits that match the stack. Use the detected package manager. Infer the dev port. The user should only need to override, not configure.
- **Time the whole thing.** Report total elapsed time at the end. This number should feel unreasonably fast for the amount of infrastructure created.
- **Never create accounts.** If a service needs an account the user doesn't have, tell them and move on. Don't block the entire flow for one missing service.
- **Rerunnable.** Running `/ignition` again on the same project should detect what already exists and skip it. Second run should complete in seconds.

## Interrupt recovery

If the user stops `/ignition` mid-flow (disconnect, ctrl-c, new conversation):

- Phase 1 artifacts persist (CLAUDE.md, launch.json, settings)
- Phase 2 artifacts persist (deployed project, database, CI config)
- Phase 3 artifacts persist (installed skills)
- Running `/ignition` again detects all existing artifacts and picks up where it left off

Nothing is in an inconsistent state. Each phase's output is independently useful.

## What "/ignition" replaces

Without /ignition, a typical new project setup:

```
Day 1:  Set up repo, install deps, get dev server running
Day 2:  Configure linter, write first test, set up CI
Day 3:  Deploy to Vercel, configure env vars
Day 4:  Set up Supabase, run first migration
Day 5:  Configure auth, debug OAuth redirects
Week 2: "I should really add Sentry..."
Week 3: "I should really add a pre-push hook..."
Never:  "I should document all this in CLAUDE.md"
```

With /ignition:

```
Minute 0:  /ignition
Minute 15: Everything above is done
Minute 16: Start building features
```
