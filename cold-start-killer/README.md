# Cold Start Killer Kit

A portable skill kit for Claude Code that eliminates the cold-start tax on new projects. Session 1 should feel like session 10.

## The Problem

Every new project pays the same tax: 3-5 sessions of Claude learning your codebase, your patterns, your preferences. You explain your stack. You correct wrong assumptions. You re-teach conventions you've already established elsewhere. By the time Claude is useful, you've burned through your most energized sessions.

## The Solution

Five skills that compress weeks of setup into one command:

- **`/bootstrap`** reads the room instead of asking questions. It detects your stack, generates a CLAUDE.md draft, sets up tooling, installs relevant kits, and scaffolds memory — all in one pass. You review and correct a first draft instead of starting from scratch.
- **`/scaffold`** wires up the entire infrastructure stack — hosting (Vercel), database (Supabase), auth (OAuth), error tracking (Sentry), testing, and CI — in one concentrated pass. Get production-ready before writing feature code.
- **`/install-kit`** brings portable skill kits into any project. Pick from your library of kits (shipping, product thinking, craft, meta-tooling, etc.) and install their skills, hooks, templates, and CLAUDE.md fragments in one step.
- **`/port`** extracts portable knowledge from a mature project into reusable kits. The skill that closes the flywheel — every project feeds back into the kit library.
- **`/ignition`** chains all of the above into one command: detect → scaffold → equip → verify. Three lightweight checkpoints, zero busywork. 15 minutes from empty repo to production-ready.

## What's included

### Skills (invoke with `/skillname`)

| Skill | Purpose | When to use |
|-------|---------|-------------|
| `/bootstrap` | First-session project wizard | First session on a new project, or when rebootstrapping after major stack changes |
| `/scaffold` | Infrastructure setup wizard | After bootstrap, to wire up hosting, DB, auth, Sentry, tests, CI |
| `/install-kit` | Install portable kits into the current project | When you want to add skills from your kit library |
| `/port` | Extract portable knowledge into kits | In a mature project, to package skills and patterns for reuse |
| `/ignition` | One-command full project setup | First session ever — runs bootstrap + scaffold + install-kit + kickoff |

### Skill flow

```
New project (the one-command path):

/ignition
    ├── Phase 1: DETECT (/bootstrap)  →  CLAUDE.md, tooling, memory
    │   ⏸ "Here's what I found. Corrections?"
    ├── Phase 2: BUILD (/scaffold)    →  Vercel, Supabase, auth, Sentry, tests, CI
    │   ⏸ "Which services?"
    ├── Phase 3: EQUIP (/install-kit) →  Skills, hooks, templates
    │   ⏸ "These kits match. All good?"
    └── Phase 4: VERIFY (/kickoff)    →  Build, test, briefing
        ✅ "Ready to build."

Mature project:

/port  →  [analyze, classify, extract portable knowledge into kits]
    └── ~/.claude/kits/  →  [ready for the next /ignition]
```

`/ignition` is the one-command path for new projects. Each phase can also be run independently. `/port` runs in a mature project to extract knowledge back into the kit library. The loop closes.

### Templates

| File | Purpose |
|------|---------|
| `templates/claude-md-starter.md` | Composable CLAUDE.md template with all standard sections |
| `templates/memory-scaffold.md` | Initial MEMORY.md structure for any project |

### Composable fragments

| File | Purpose |
|------|---------|
| `claude-md-fragment.md` | Drop-in CLAUDE.md section explaining how the project was bootstrapped |

## Installation

1. This kit lives at `~/.claude/kits/cold-start-killer/`
2. Skills are automatically available as slash commands in any project
3. Run `/bootstrap` in a new project to generate everything
4. Run `/install-kit` to add more capabilities later

## Philosophy

The best onboarding does not ask questions -- it reads the room and confirms. A developer starting a new project should not fill out forms. They should see an informed first draft and say "yes, except..."

Detection beats interrogation. A manifest file tells you more than five questions. A directory structure tells you more than a survey. Git history tells you more than a README. Read everything available, infer what you can, mark what you cannot, and present a draft for correction.

## Design principles

- **Project-agnostic.** Detects and adapts to any stack: JavaScript, Python, Rust, Go, Ruby, Java, or anything with a manifest file.
- **Non-destructive.** Never overwrites existing files. If CLAUDE.md exists, diffs against it. If skills exist, skips them.
- **Opinionated defaults, easy overrides.** The generated CLAUDE.md is a draft. The kit recommendations are suggestions. The user always has the final word.
- **Portable.** Everything generated works without this kit installed. The output is standard Claude Code infrastructure, not a proprietary format.
- **Idempotent.** Running `/bootstrap` twice on the same project produces the same result (minus anything the user already corrected).
