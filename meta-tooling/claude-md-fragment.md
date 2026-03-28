## Meta-Tooling

The agents that improve other agents. Five skills that keep the development infrastructure healthy, growing, and honest.

### Philosophy

Skills compound across sessions. A skill built today saves time in every future session. But skills also accumulate -- dead skills burn context, overlapping skills create confusion, and unmeasured skills are untested assumptions. The meta-tooling kit manages this lifecycle:

- **`/agent-zero`** audits the Claude Code setup (config, memory, skills, advanced patterns) and scores it. Run periodically to catch infrastructure drift.
- **`/builder`** analyzes friction in git history, memory files, and workflow gaps to propose new skills. Every proposal cites evidence. Run at inflection points or when workflows feel clunky.
- **`/subtractor`** finds dead code, dead features, unused dependencies, and over-abstractions. Presents a ranked removal list -- never auto-deletes. Run when the codebase feels heavy.
- **`/metrics`** queries available data sources (analytics tables, event logs, runtime logs) to answer product questions with data, not opinions. Run after shipping features to measure impact.
- **`/eli5`** re-explains the last discussion (or any named concept) in plain language with analogies. Run after dense technical discussions or before sharing findings with non-technical people.

### The meta-tooling loop

```
/agent-zero  -->  [identify gaps]  -->  /builder  -->  [build skills]
                                                            |
/subtractor  <--  [prune dead weight]  <--  [ship + measure with /metrics]
```

Growth without pruning is hoarding. Pruning without measurement is guessing. This loop keeps the ecosystem healthy.
