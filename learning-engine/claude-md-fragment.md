## Learning Engine

This project uses the Learning Engine kit (`~/.claude/kits/learning-engine/`) to compound knowledge across sessions and projects.

### The Learning Loop

```
Ship code --> /reflect --> Extract lessons --> Save to journals
                                                     |
                                                     v
                              Next session: /antipattern --> Prevent known failures
                                                     |
                                                     v
                              Next project: calibration-profile --> Warm-start
```

### When to run /reflect

- **End of every session** — pairs naturally with /wrapup. Extract lessons while context is fresh.
- **After significant failures** — the most valuable lessons come from surprises. Don't wait for session end.
- **After pivots** — when you changed direction mid-session, the reason for the pivot is worth capturing.

### When to run /antipattern

- **Before risky operations** — type widening, storage migrations, auth changes, toggle additions.
- **When editing files with known failure history** — the failure journal tracks which files caused past issues.
- **When the operation "feels familiar"** — if you've been burned by something similar before, check the journal.

### Memory files (project-level)

| File | Purpose | Updated by |
|------|---------|------------|
| `instincts-journal.md` | Confirmed/disproven instincts | /reflect |
| `failure-journal.md` | Technical traps with trigger conditions | /reflect |
| `calibration-profile.md` | Working style preferences | /reflect |

These files live in the project's memory directory. Templates are in `~/.claude/kits/learning-engine/memory-templates/`.

### How it compounds

The instincts journal and failure journal grow across sessions. Each `/reflect` adds entries. Each `/antipattern` run queries them. Over time:

- The failure journal becomes an immune system — traps you've fallen into once never catch you again
- The instincts journal becomes a decision-making accelerator — tested beliefs replace guesswork
- The calibration profile means new projects inherit your working style from day one

The compounding only works if `/reflect` runs consistently. A journal with 2 entries is a Post-it note. A journal with 40 entries is institutional knowledge.
