# Craft & Delight Kit

A portable skill kit for Claude Code that makes products feel *crafted*, not just correct. Install once, bring taste to every project.

## Philosophy

In a world where anyone can ship software, the products that survive are the ones that feel crafted. Not polished -- crafted. The difference is soul. Polish is a surface treatment. Craft is structural. It's the animation that makes a state transition feel inevitable. The empty state that makes a new user feel welcomed instead of lost. The error message that sounds like a person wrote it.

This kit trains your development workflow to notice, measure, and create those moments. It won't write your features for you -- it will make you care about how they feel.

## What's included

### Skills (invoke with `/skillname`)

| Skill | Purpose | When to use |
|-------|---------|-------------|
| `/delight` | Find and create moments that make people feel something | After shipping features, when the product feels functional but not magical |
| `/snapshot` | Before/after visual diff of UI changes | After shipping visible UI changes, for internal documentation |
| `/recap` | Session recap card | End of productive sessions, to celebrate what was shipped |
| `/announce` | Generate branded assets for shipped features | After shipping, when you need social cards or release announcements |

### Skill flow

```
[ship a feature]  -->  /snapshot  -->  /delight  -->  /announce
                                                         |
                                                     /recap (end of session)
```

`/delight` is the analytical core -- it finds opportunities. `/snapshot` captures what changed visually. `/announce` packages it for the world. `/recap` celebrates it internally.

### Memory templates

| File | Purpose |
|------|---------|
| `memory-templates/design-taste.md` | Track aesthetic preferences learned from team feedback |

Copy this template to your project's memory directory and fill it in over time. The more taste data you accumulate, the fewer design questions you need to ask.

### CLAUDE.md fragment

| File | Purpose |
|------|---------|
| `claude-md-fragment.md` | Drop-in CLAUDE.md section for visual verification and taste calibration |

Append this to any project's `CLAUDE.md` to enable the reflexive visual verification loop and design taste calibration process.

## Installation

1. Copy this kit to `~/.claude/kits/craft-and-delight/`
2. Skills are automatically available as slash commands in any project
3. Copy `memory-templates/design-taste.md` to your project's memory directory
4. Append `claude-md-fragment.md` to your project's `CLAUDE.md`

## Design principles

- **Project-agnostic.** No references to specific frameworks, features, or products. Works with any codebase that has a UI.
- **Opinionated about quality, flexible about tools.** The standards are fixed. The implementation adapts to what's available (Canva MCP, preview tools, plain markdown).
- **Taste compounds.** Every session that records a design preference makes the next session smarter. The memory template is the compounding asset.
- **Protect what's good.** These skills find opportunities -- they never recommend removing something that already works well. Improvement, not replacement.
- **Feelings are data.** "This feels off" is a valid finding. The skill's job is to make that feeling specific and actionable.
