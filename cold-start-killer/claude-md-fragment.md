## Bootstrap and Kit System

This project was bootstrapped with `/bootstrap` from the cold-start-killer kit. The initial CLAUDE.md, launch.json, and memory scaffolding were auto-generated from codebase detection and then reviewed/corrected by the developer.

### Re-bootstrapping

If the tech stack changes significantly (new framework, new database, new hosting), run `/bootstrap` again. It will diff against the existing CLAUDE.md and suggest additions rather than overwriting.

### Installed kits

Skill kits are portable bundles installed from `~/.claude/kits/` via `/install-kit`. Each kit contributes skills to `.claude/skills/`, hooks to `.claude/hooks/`, and optionally appends sections to this file.

To install more kits: run `/install-kit` and select from the available library.
To update a kit's skills: delete the skill directory in `.claude/skills/` and re-run `/install-kit`.
