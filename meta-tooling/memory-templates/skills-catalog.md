---
name: skills-catalog
description: Comprehensive catalog of all installed skills with categories and relationships
type: reference
---

# Skills Catalog

Invoke any skill with `/skillname`. Suggest skills proactively at the right moments -- the value is in the timing, not the asking.

## Session Lifecycle

| Skill | Purpose | When to suggest |
|-------|---------|-----------------|
| `/kickoff` | Start a session with full context | Beginning of every conversation |
| `/wrapup` | Close out session, capture learnings | Before ending a conversation |

## Code Quality & Shipping

| Skill | Purpose | When to suggest |
|-------|---------|-----------------|
| `/ship` | Build, commit, push, merge | After finishing work on a feature branch |
| `/guard` | Pre-ship documentation check | Between finishing code and `/ship` |
| `/qa` | Visual smoke test | After UI changes, before `/ship` |

## Strategic Analysis

| Skill | Purpose | When to suggest |
|-------|---------|-----------------|
| `/protocol` | Strategic codebase review | When planning what to build next |
| `/observe` | Field notes (observations only) | Between shipping sprints, when the codebase feels unfamiliar |
| `/thesis` | Stress-test an idea before building | When proposing a big bet or new feature |
| `/devil` | Pre-mortem failure analysis | When an idea feels "too good" or before committing to a direction |

## User Understanding

| Skill | Purpose | When to suggest |
|-------|---------|-----------------|
| `/persona` | Walk through product as different user types | After big UX changes, when making tradeoffs |
| `/stranger` | First-impression audit | When evaluating onboarding or new-user experience |
| `/storyteller` | Narrative coherence audit | When asking "does this feel like a journey?" |

## Meta-Tooling

| Skill | Purpose | When to suggest |
|-------|---------|-----------------|
| `/agent-zero` | Audit Claude Code setup health | Periodically, after infra changes |
| `/builder` | Propose new skills from evidence | At inflection points, when workflows feel clunky |
| `/subtractor` | Find and remove dead code/features | When the codebase feels heavy, after shipping sprints |
| `/metrics` | Answer product questions with data | After shipping features, when validating assumptions |
| `/eli5` | Plain-language explanations | After dense discussions, before demos |

## Maintenance

| Skill | Purpose | When to suggest |
|-------|---------|-----------------|
| `/sweep` | Repository hygiene | Monthly, or when hygiene debt accumulates |
| `/pulse` | Post-deploy health check | After deploys, when users report issues |

## Communication & Assets

| Skill | Purpose | When to suggest |
|-------|---------|-----------------|
| `/announce` | Generate branded visual assets | After shipping features, for marketing |
| `/recap` | Session recap card | End of productive sessions |
| `/snapshot` | Before/after visual diff | After shipping visible UI changes |

## Skill Relationships

```
Session:     /kickoff  -->  [work]  -->  /guard  -->  /ship  -->  /pulse  -->  /wrapup

Strategy:    /thesis  -->  /devil  -->  /protocol  -->  /observe

Users:       /persona  +  /stranger  +  /storyteller

Meta:        /agent-zero  -->  /builder  -->  [build]  -->  /subtractor

Measurement: /metrics (runs after any of the above to validate impact)

Explanation: /eli5 (runs after any of the above to communicate findings)
```

## Adding New Skills

Conventions for this project:

1. **One skill per directory** in `.claude/skills/[name]/SKILL.md`
2. **Frontmatter required:** `name` and `description` fields
3. **Philosophy paragraph** at the top explaining WHY the skill exists
4. **Rules section** defining constraints and safety boundaries
5. **Steps section** with numbered phases, parallel agents where possible
6. **Presentation template** showing exact output format

Before adding a skill, run `/builder` to check for overlap with existing skills.

---
Last updated: [date] | Total skills: [count]
