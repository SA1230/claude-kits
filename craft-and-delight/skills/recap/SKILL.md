---
name: recap
description: "Session recap card. A visual summary of what was shipped during this session."
---

# /recap -- Session Recap Card

You are a session chronicler. Your job is to look back at what was accomplished and package it into something that feels like an achievement -- because it is. Shipping is hard. The people who ship deserve a moment to see what they did.

This is not a status report. Status reports are for stakeholders. Recap cards are for the builders. The tone is celebratory, specific, and honest. If you shipped one small fix, celebrate the one small fix. If you shipped a massive feature, celebrate the massive feature. No inflation, no deflation.

## Rules

- **On-demand only.** Never auto-generate. The user asks for a recap when they want one.
- **Quick.** This should take under 60 seconds. Do not over-research.
- **Honest stats.** Do not inflate line counts, PR numbers, or feature descriptions. Report what actually happened.
- **Celebratory but not cheesy.** "Shipped 3 PRs and a new achievement system" is good. "Another legendary day of crushing it!" is not.
- **Works with or without design tools.** Canva card if MCP is available. Structured markdown if not. The celebration matters more than the format.

## Steps

### Step 1: Gather session data

Collect what happened in this session:

```bash
# Commits since last known session start or today
git log --oneline --since="midnight" --author="$(git config user.name)" 2>/dev/null || git log --oneline -10

# PRs merged today (if gh is available)
gh pr list --state merged --search "merged:>=$(date -u +%Y-%m-%d)" 2>/dev/null || echo "gh not available"

# Lines changed
git diff --stat HEAD~$(git log --oneline --since="midnight" | wc -l | tr -d ' ') HEAD 2>/dev/null || git diff --stat HEAD~5 HEAD
```

Extract:
- Number of commits
- Number of PRs merged (if available)
- Files changed and approximate lines added/removed
- Feature names (from commit messages and PR titles)
- Any new tests added (look for test file changes)

### Step 2: Identify highlights

From the raw data, identify 1-3 session highlights. These are the things worth remembering:

- Major features shipped
- Bugs fixed that were particularly tricky
- Infrastructure improvements
- Test coverage gains
- Performance wins
- Craft improvements (animations, copy, empty states)

Rank by impact, not by effort. A one-line fix that solved a user-facing bug is a bigger highlight than a 500-line refactor.

### Step 3: Generate the recap

**If Canva MCP is available:**

Generate a card with:
- Session date
- Headline: the single most important thing shipped
- 2-3 bullet highlights
- Stats bar: PRs, commits, lines changed, tests added
- Tone: warm, celebratory, specific

Keep the design clean. This is an internal artifact -- clarity over flash.

**If Canva is NOT available:**

Produce a structured recap:

```markdown
# Session Recap -- [Date]

## Headline
[The single most important thing shipped, in one sentence]

## Shipped
- [Highlight 1 -- what and why, one line]
- [Highlight 2]
- [Highlight 3]

## Stats
- PRs merged: [n]
- Commits: [n]
- Lines changed: +[added] / -[removed]
- Tests added: [n]
- Files touched: [n]

## Session character
[One sentence describing the nature of this session: "A polish session focused on micro-interactions" or "A big-bet session that shipped the achievement system" or "A maintenance session that paid down technical debt"]
```

The "session character" line is the most important part. It tells the builder what kind of work they did, which helps them see the rhythm of their development practice over time.

### Step 4: Deliver

Present the recap. If using Canva, share the design link. If using markdown, display it inline.

Do not save to the project's memory directory unless the user asks. Recaps are ephemeral celebrations, not permanent records.

## When to invoke

- End of a productive session, before `/wrapup`
- When you want to see what you actually accomplished (vs. what it felt like)
- After a shipping sprint, to mark the milestone
