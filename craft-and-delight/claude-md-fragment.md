# Visual Verification & Design Taste

Composable CLAUDE.md section from the craft-and-delight kit. Append this to your project's CLAUDE.md.

---

## Visual Verification (the reflexive loop)

When verifying UI changes via screenshots or preview tools, evaluate for **quality** -- not just correctness. Every screenshot is an opportunity to catch taste issues before they reach QA or shipping. Ask yourself:

- **Empty states:** Does this feel inviting or barren? Would a new user feel welcomed or confused?
- **Contrast & readability:** Is all text easily readable? Would low-vision users struggle?
- **Visual hierarchy:** Does the eye know where to go first? Is the most important action obvious?
- **First-timer clarity:** Would someone who has never seen this app understand what to do here?
- **Spacing & rhythm:** Does the layout feel intentional or accidental? Any awkward gaps or cramping?
- **Emotional tone:** Does this screen feel like the rest of the app, or does it break the mood?
- **State transitions:** When something changes, does it animate or just pop? Is the transition speed consistent with the rest of the app?

This is a reflexive loop: **change -> screenshot -> evaluate (structure + quality) -> fix -> screenshot again -> repeat until it looks good, not just "not broken."**

Flag quality observations inline during development and fix them before reaching QA. The goal is that by the time QA runs, both structure AND taste have already been addressed.

## Design Taste Calibration

When a UI decision is ambiguous (spacing, copy, color intensity, layout choice), present the team with a targeted A/B question -- two concrete options, quick to answer. Record their preference in the design taste profile (usually in the project's memory directory as `design-taste.md`).

Over time, the taste profile gets sharp enough to make most decisions confidently without asking. Consult the taste profile before making aesthetic choices -- if a relevant preference exists, follow it.

**Good calibration questions:**
- "Card elevation: subtle border or light background tint?" (show both)
- "Modal transition: 150ms snappy or 300ms smooth?"
- "Error tone: 'That didn't work -- try again?' or 'Something went wrong. Please retry.'"

**Bad calibration questions:**
- "What do you think of the design?" (too open-ended)
- "Should I use blue or green?" (without showing the context)
- "Do you like animations?" (too abstract)

The best questions are binary, visual, and take under 5 seconds to answer.

## Quality Evaluation Checklist

Run this mental checklist on every screenshot during development:

| Check | Question | Fix if... |
|-------|----------|-----------|
| Empty state | If this had no data, would it feel welcoming? | Barren, confusing, or showing raw "no items" text |
| Loading state | Does the user know something is happening? | Blank screen, no spinner/skeleton, jarring content pop-in |
| Error state | Does the error feel human and actionable? | Generic browser errors, technical jargon, no recovery path |
| Contrast | Can all text be read at arm's length? | Light text on light backgrounds, low-contrast accent colors |
| Hierarchy | Is the primary action the most visually prominent thing? | Secondary actions competing for attention, buried CTAs |
| First-timer | Would a stranger know what to do on this screen? | Jargon, assumed context, no onboarding cues |
| Spacing | Does every gap look intentional? | Uneven padding, cramped sections next to airy ones |
| Consistency | Does this screen match the others? | Different card styles, mismatched fonts, inconsistent icons |
| Tone | Does this feel like the same product? | Mood breaks, tonal shifts, one screen feels corporate while others feel playful |
