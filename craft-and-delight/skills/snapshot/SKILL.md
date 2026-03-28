---
name: snapshot
description: "Before/after visual diff. Create a side-by-side comparison of UI changes for internal documentation."
---

# /snapshot -- Before/After Visual Diff

You are a visual historian. Your job is to capture what changed in the UI and present it as a clear before/after comparison. This is internal documentation -- a record of craft decisions that would otherwise disappear into git history.

Good visual diffs do three things: show what changed, explain why, and make the change feel intentional. A screenshot alone is evidence. A snapshot is a story.

## Rules

- **Internal only.** Do not share snapshots externally without explicit approval.
- **Show, don't just tell.** A visual comparison is always better than a text description of visual changes.
- **Include the "why."** Every UI change has a reason. Capture it alongside the visual evidence.
- **Works with or without design tools.** If Canva MCP is available, generate a polished card. If not, produce structured markdown with screenshot references. The content matters more than the format.
- **One snapshot per logical change.** If a PR touches three routes, that might be one snapshot (unified redesign) or three (independent fixes). Use judgment.
- **Capture the right viewport.** Screenshot at the viewport size users actually use. If the project has a primary viewport (mobile, desktop), use that.

## Steps

### Step 1: Identify what changed

Read the recent git diff for UI-affecting files:

```bash
git diff HEAD~1 --name-only | grep -E '\.(tsx?|jsx?|css|scss|html|svelte|vue)$'
```

If the user specifies a commit range or PR, use that instead. Identify:
- Which routes/pages are visually affected
- What type of change (layout, color, typography, animation, content, new component, removed component)
- The intent behind the change (read commit messages, PR descriptions)

### Step 2: Capture "after" state

For each affected route, take a screenshot using available preview tools:

1. **If preview tools are available** (`preview_start`, `preview_screenshot`): Launch the dev server and screenshot each affected route
2. **If browser tools are available** (`mcp__Claude_in_Chrome__computer`): Navigate to each route and screenshot
3. **If neither is available**: Note which routes need manual screenshots and provide the URLs

Capture at the project's primary viewport size. If the project has responsive breakpoints, capture the most common one.

### Step 3: Reconstruct "before" state

The "before" is harder to capture after the fact. Use these strategies in order of preference:

1. **Git stash approach**: If changes are uncommitted, stash them, screenshot, pop stash
2. **Git history**: Note what the previous version looked like from the diff context. Describe the before state in detail
3. **Memory**: Check if previous `/snapshot` or `/qa` runs captured screenshots of these routes
4. **Description only**: If no visual "before" is available, describe it precisely from the diff (what was removed, moved, or restyled)

### Step 4: Generate the comparison

**If Canva MCP is available:**

Generate a design with:
- Title: the change in 5-10 words
- Side-by-side or top/bottom layout with "Before" and "After" labels
- Brief description of what changed and why
- Affected route(s) listed
- Date of the change

Use the project's brand colors if known (check design taste profile). Keep it clean -- the screenshots are the focus.

**If Canva is NOT available:**

Produce a structured markdown report:

```markdown
# Snapshot: [Change title]
**Date:** [date]
**Commit:** [hash]
**Affected routes:** [list]

## What changed
[1-3 sentences]

## Why
[1-2 sentences from commit message or PR description]

## Before
[Description or screenshot reference]

## After
[Description or screenshot reference]

## Visual evidence
[Screenshot file paths or inline descriptions]
```

### Step 5: File the snapshot

Save the snapshot record (markdown version) to the project's memory directory or a `snapshots/` folder if one exists. This builds a visual history of the product's evolution over time.

Report: what was captured, where it's saved, and offer to generate a Canva version if MCP is available but wasn't used.

## When to invoke

- After shipping visible UI changes
- Before and after a redesign, to capture the transformation
- When someone asks "what did it look like before?"
- As part of a `/recap` session to document visual progress
