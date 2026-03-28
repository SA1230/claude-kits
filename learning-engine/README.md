# Learning Engine Kit

The kit that makes every project make the next project better.

## Philosophy

Most development sessions produce two outputs: shipped code and invisible learning. The code gets committed. The learning evaporates by the next morning. This kit captures the learning and turns it into active interventions.

The difference between a developer with 10 years of experience and a developer with 1 year of experience repeated 10 times is whether failures become immune responses. This kit is the immune system.

## Three Pillars

### Reflect — Extract lessons before they evaporate

At the end of every session, decisions were made, surprises happened, and assumptions were tested. `/reflect` captures these as structured, reusable knowledge before the context window closes.

Not everything is worth saving. "We ran tests and they passed" is noise. "Tests passed but the feature was broken because tests didn't cover the integration path" is signal. The bar is surprise — if it wasn't surprising, it's not a lesson.

### Antipattern — Prevent repeats at the moment of risk

A failure journal nobody reads is a filing cabinet. An antipattern detector that fires at the right moment is an immune system. The difference is timing.

`/antipattern` scans current work against known failure patterns and surfaces warnings before you fall into the same trap twice. It doesn't block — it informs. False positives are better than missed warnings.

### Calibrate — Transfer preferences across projects

Every project teaches you about your own working style — code preferences, communication patterns, design taste, decision frameworks. The calibration profile captures these so new projects warm-start instead of cold-start.

## How It Compounds

```
Session 1: Ship code. /reflect extracts 3 lessons. 2 go to instincts journal, 1 to failure journal.
Session 2: /antipattern catches a trigger match from Session 1's failure. You avoid the trap.
Session 5: Instincts journal has 12 entries. You start noticing cross-project patterns.
Session 20: The failure journal has 8 active traps. New projects inherit all of them.
Project 2: Calibration profile warm-starts the working relationship. No re-learning needed.
Project 5: 40+ instincts, 15+ traps, and a sharp calibration profile. Every session starts smarter.
```

## Skills

| Skill | Purpose | When to run |
|-------|---------|-------------|
| `/reflect` | Extract lessons from a session | End of session, after significant failures, after pivots |
| `/antipattern` | Check current work against known failure patterns | Before risky operations, when editing files with past issues |

## Memory Templates

| Template | Purpose |
|----------|---------|
| `instincts-journal.md` | Confirmed/disproven instincts across projects |
| `failure-journal.md` | Technical traps with trigger conditions for /antipattern |
| `calibration-profile.md` | Portable working style preferences |

## Installation

This kit lives at `~/.claude/kits/learning-engine/` and is available in every project. Memory files are created in the project's memory directory on first use.

## The Learning Loop

```
Ship --> Reflect --> Extract --> Store
                                  |
                                  v
                    Next Session: Antipattern --> Prevent
                                  |
                                  v
                    Next Project: Calibrate --> Warm-start
```

Learning isn't passive. Reading memories is passive. Active learning means interventions that fire at the right moment — before you make the mistake, not after you've already shipped it.
