# Product Thinking Kit

A portable skill kit for Claude Code that brings structured product thinking to any project. Seven skills that help you decide what to build, what not to build, and whether what you built actually works.

## The Skills

### Decision Skills (before you build)

- **`/thesis`** -- Stress-test an idea before building it. Frames every feature as a bet with explicit assumptions, finds the weakest link, identifies the cheapest test. Use when someone says "should we build X?"
- **`/devil`** -- Argue against everything. Four agents attack your assumptions, find competitors you missed, simulate user dropout, and predict technical failures. Use when an idea feels "too good" or when you need a pre-mortem.

### Analysis Skills (understanding what you have)

- **`/protocol`** -- Strategic review of the entire codebase. Evaluates product coherence, technical health, user journey, and growth potential. Outputs a tiered build list with a "what NOT to build" section. Use when planning what to work on next.
- **`/observe`** -- Field notes. Notices what nobody asked about: growth patterns, drift, thematic connections, things that would confuse a newcomer. Critically, it only observes -- never prescribes. Use when the codebase feels unfamiliar or between shipping sprints.

### User Skills (understanding who you serve)

- **`/persona`** -- Become 3-4 real user types and walk through the product as each. Finds where power users and casual users want opposite things. Outputs a conflict map and core user verdict. Use when making UX tradeoffs or after big changes.
- **`/stranger`** -- First-impression audit. Four agents simulate a new user with different reading styles and patience levels. Measures clarity, friction, hook quality, and jargon. Use when evaluating onboarding or asking "would a new user get this?"
- **`/storyteller`** -- Narrative coherence audit. Walks through the product timeline from first touch to power user. Finds dead spots, emotional peaks, and narrative gaps. Use when asking "does this feel like a journey or a toolbox?"

## How They Connect

```
Idea Phase:     /thesis  -->  /devil
                   |            |
                   v            v
Planning:       /protocol (what to build + what NOT to build)
                   |
                   v
Building:       /observe (periodic health checks)
                   |
                   v
Evaluating:     /persona  +  /stranger  +  /storyteller
```

- Start with `/thesis` when you have an idea. If it survives, run `/devil` to find failure modes.
- Use `/protocol` to prioritize across multiple ideas and assess codebase health.
- Run `/observe` periodically while building -- it catches drift you won't notice yourself.
- After shipping, use `/persona` (are different user types served?), `/stranger` (can new users figure it out?), and `/storyteller` (does the whole thing feel cohesive?).

## Installation

This kit lives at `~/.claude/kits/product-thinking/`. To make the skills available in any project, the kit directory is automatically discovered by Claude Code.

The `claude-md-fragment.md` file contains a composable decision framework you can paste into any project's `CLAUDE.md` to encode product thinking habits directly into your development workflow.

## Philosophy

Building is easy. Building the right thing is hard. Building the right thing and knowing you built the right thing is the whole game.

These skills exist because the most expensive bugs are not in your code -- they are in your assumptions. A feature nobody needed costs more than a bug that crashes the app, because the bug gets fixed in a day and the feature haunts the codebase forever.
