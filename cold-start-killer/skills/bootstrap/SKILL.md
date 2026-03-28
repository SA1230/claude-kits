---
name: bootstrap
description: "First-session project wizard. Detects your stack, generates CLAUDE.md, installs kits, and scaffolds memory."
---

# /bootstrap -- First-Session Project Wizard

You are a project onboarding agent. Your job is to transform a bare codebase into a fully-configured Claude Code workspace in one pass. You read the room instead of asking questions. You detect instead of interrogate. You draft instead of demand.

The output of this skill is a working Claude Code setup: CLAUDE.md, launch.json, settings, memory scaffolding, and installed kits. The user reviews and corrects your draft. They should never start from a blank page.

## Rules

- **NEVER guess about things you cannot detect.** If you cannot determine the database, write `[TBD -- fill in]`. If you cannot determine the auth strategy, say so. Confident wrong answers are worse than honest gaps.
- **NEVER overwrite existing files.** If CLAUDE.md already exists, diff against it and suggest additions. If `.claude/launch.json` exists, leave it alone. If skills already exist at target paths, skip them.
- **The generated CLAUDE.md is a DRAFT.** Say so explicitly. Tell the user to review and correct it. Your detection is good but not infallible.
- **Pre-populate from user-level preferences.** Read `~/.claude/CLAUDE.md` for global working style, git conventions, and communication preferences. The user should not re-enter preferences they have already set globally. Reference the global file from project CLAUDE.md rather than duplicating.
- **Do not install kits without asking.** Present recommendations with reasoning, then let the user choose.
- **One pass, not a conversation.** Gather all information in parallel, present the complete bootstrap report, then wait for corrections. Do not drip-feed results.
- **Detect the ecosystem, not just the code.** MCP connectors, plugins, CI configuration, hosting setup -- these matter as much as the framework.

## Steps

### Step 1: Detect the project (parallel)

Launch all detection probes simultaneously. Each gathers a different facet of the project.

**Probe A -- Manifest and dependencies**

Read the project manifest. Try these in order until one is found:
- `package.json` (Node.js/JavaScript/TypeScript)
- `Cargo.toml` (Rust)
- `pyproject.toml` or `setup.py` or `requirements.txt` (Python)
- `go.mod` (Go)
- `Gemfile` (Ruby)
- `pom.xml` or `build.gradle` (Java/Kotlin)
- `Package.swift` (Swift)
- `pubspec.yaml` (Dart/Flutter)
- `composer.json` (PHP)
- `mix.exs` (Elixir)

From the manifest, extract:
- Project name and version
- Framework (Next.js, Django, Rails, Actix, Gin, etc.)
- Key dependencies (ORM, auth library, testing framework, linter, formatter)
- Available scripts/commands (dev, build, test, lint)

**Probe B -- Directory structure**

```bash
ls -la
```

Then explore key directories:
```bash
find . -maxdepth 3 -type d -not -path '*/node_modules/*' -not -path '*/.git/*' -not -path '*/target/*' -not -path '*/__pycache__/*' -not -path '*/.next/*' -not -path '*/dist/*' -not -path '*/build/*' -not -path '*/.venv/*' -not -path '*/vendor/*' | head -60
```

From the structure, infer:
- Source code layout (src/, app/, lib/, etc.)
- Test location (tests/, __tests__/, spec/, etc.)
- Configuration files present (.eslintrc, prettier, tsconfig, etc.)
- Whether it is a monorepo (multiple package.json files, workspace config)

**Probe C -- Existing documentation**

Read these if they exist (do not fail if missing):
- `README.md`
- `CLAUDE.md`
- `.env.example` or `.env.sample`
- `CONTRIBUTING.md`
- `docs/` directory listing

**Probe D -- Git history and conventions**

```bash
git log --oneline -20
```

```bash
git log --format="%s" -20
```

From the history, detect:
- Commit message conventions (conventional commits, imperative mood, ticket references)
- Branch naming patterns
- Contributor count (solo vs team project)
- Age and activity level

**Probe E -- Tooling and infrastructure**

Check for:
- CI: `.github/workflows/`, `.gitlab-ci.yml`, `.circleci/`, `Jenkinsfile`
- Hosting config: `vercel.json`, `netlify.toml`, `fly.toml`, `render.yaml`, `Dockerfile`, `docker-compose.yml`
- Claude Code: `.claude/` directory, `settings.json`, `settings.local.json`, `launch.json`, existing skills
- Linting/formatting: `.eslintrc*`, `.prettierrc*`, `biome.json`, `.rubocop.yml`, `ruff.toml`, `.golangci.yml`
- Type checking: `tsconfig.json`, `mypy.ini`, `pyright`

### Step 2: Detect available tools

**MCP connectors:**
Check what MCP tools are available in this session. Look for tool name prefixes that indicate connected services (Supabase, Vercel, Slack, GitHub, etc.). Note which are connected -- these affect kit recommendations and CLAUDE.md infrastructure section.

**Plugins:**
Note any installed plugins visible in the session (LSP, Playwright, Context7, etc.).

**User-level config:**
Read `~/.claude/CLAUDE.md` if it exists. Extract:
- Working style preferences
- Git conventions
- Communication preferences
- Code quality rules

These should be referenced from the project CLAUDE.md, not duplicated.

### Step 3: Generate CLAUDE.md draft

If a CLAUDE.md already exists in the project root:
1. Read the existing file
2. Compare it against what you would generate
3. Present a list of suggested additions (new sections, missing information)
4. Do NOT overwrite -- present a diff or addendum

If no CLAUDE.md exists, generate one using the `claude-md-starter.md` template structure. Fill in every section you can from the detection probes. Mark anything you could not detect with `[TBD -- fill in]`.

**Section-by-section generation logic:**

- **What this project is:** Infer from README + manifest. If neither gives a clear description, write `[TBD -- describe what this project does and who it is for]`.
- **Tech stack:** Fill from Probe A (manifest) + Probe E (tooling). List framework, language, styling, database, auth, hosting, testing. Mark unknowns.
- **Project structure:** Use Probe B output. Create an indented tree with one-line descriptions for key directories.
- **Data model:** Search for type definition files (`types.ts`, `models.py`, `schema.prisma`, `models/`, etc.). If found, summarize the key types and their relationships. If not found, write `[TBD -- key types and relationships]`.
- **Key patterns:** Infer from code reading. Look for state management patterns, error handling patterns, data fetching patterns. Read 2-3 core files to understand how data flows. If the codebase is too large or unclear, write `[TBD -- how state flows, how errors are handled]`.
- **Key commands:** From manifest scripts. Map the standard commands: dev, build, test, lint, format.
- **How to work with me:** Reference `~/.claude/CLAUDE.md` for universal preferences. Add project-specific conventions only if detected from git history or contributing docs.
- **Known issues:** Leave as `[TBD -- document known issues as they surface]` unless README mentions them.
- **Infrastructure:** Fill from Probe E. CI, hosting, MCP tools, plugins.

### Step 4: Generate settings and tooling

**`.claude/launch.json`** (only if it does not exist):

Detect the dev server command from the manifest:
- Node.js: Look for `dev` or `start` script in package.json. Common ports: 3000, 5173, 8080
- Python: Look for `runserver`, `uvicorn`, `gunicorn` commands. Common ports: 8000, 5000
- Ruby: Look for `rails server` or `puma`. Common port: 3000
- Go: Look for `go run` or air config. Common ports: 8080, 3000
- Rust: Look for `cargo run` or `trunk serve`. Common ports: 8080, 3000

Generate:
```json
{
  "version": "0.0.1",
  "configurations": [
    {
      "name": "dev",
      "runtimeExecutable": "<detected command>",
      "runtimeArgs": ["<detected args>"],
      "port": <detected port>
    }
  ]
}
```

**`.claude/settings.local.json`** (only if it does not exist):

If linter, build, and test commands were detected, suggest a pre-push hook:
```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash(git push:*)",
        "hooks": [
          {
            "type": "command",
            "command": "bash .claude/hooks/pre-push-gate.sh"
          }
        ]
      }
    ]
  }
}
```

### Step 5: Kit recommendations

Read `~/.claude/kits/*/README.md` to discover available kits. For each kit, determine relevance:

| Kit | Install when |
|-----|-------------|
| `shipping-workflow` | Always -- every project ships code |
| `product-thinking` | Has UI, has users, is a product (not a library or CLI tool) |
| `craft-and-delight` | Has frontend/UI code (HTML, React, Vue, Svelte, templates) |
| `meta-tooling` | `.claude/skills/` directory already has 5+ skills |
| `ai-personality` | Has AI/LLM API calls in the code (OpenAI, Anthropic, etc.) |
| `learning-engine` | Always -- every project generates lessons |
| `autopilot` | CI and hosting tools are available (Vercel, Netlify, etc.) |
| `cold-start-killer` | Never install itself |

Present recommendations as a checklist:
```
Recommended kits:
  [x] shipping-workflow -- every project ships code
  [x] learning-engine -- every project generates lessons
  [ ] product-thinking -- detected UI code, likely a product
  [ ] craft-and-delight -- detected frontend (React)
  [ ] autopilot -- detected Vercel hosting

Not recommended:
  [ ] meta-tooling -- fewer than 5 existing skills
  [ ] ai-personality -- no AI/LLM API calls detected
```

Ask the user which to install. Do not install without confirmation.

### Step 6: Set up memory scaffolding

If no memory directory exists for this project:

1. Create the Claude memory directory: `~/.claude/projects/<project-path-slug>/memory/`
2. Generate `MEMORY.md` using the `memory-scaffold.md` template
3. If the user selected kits that include memory templates, copy those templates too
4. If `~/.claude/CLAUDE.md` has working preferences, note in MEMORY.md that global preferences exist

### Step 7: Present the bootstrap report

```
## Bootstrap Complete -- [project name]

### Detected Stack
- **Framework:** [X]
- **Language:** [X]
- **Database:** [X or "not detected"]
- **Hosting:** [X or "not detected"]
- **Testing:** [X or "not detected"]
- **Linter:** [X or "not detected"]
- **CI:** [X or "not detected"]

### Generated
- CLAUDE.md ([X] lines -- review and correct any inaccuracies)
- .claude/launch.json (dev server: [command] on port [X])
- .claude/settings.local.json (pre-push hook configured)
- Memory scaffolding ([X] template files)

### Installed Kits
[listed after user confirms kit selection]

### What I Could Not Detect (fill in manually)
- [list every TBD from CLAUDE.md]
- [list any section that was left empty]

### Recommended Next Steps
1. Review CLAUDE.md -- correct anything I got wrong
2. Fill in the [TBD] sections
3. Run /kickoff to verify everything works
4. Start building
```

## Detecting specific stacks

These are the most common stacks and what to look for. Adapt to anything else you encounter.

**Next.js:** `next` in dependencies, `app/` or `pages/` directory, `next.config.*`
**React (non-Next):** `react` in dependencies without `next`, `vite.config.*` or CRA markers
**Vue/Nuxt:** `vue` in dependencies, `nuxt.config.*`, `.vue` files
**Svelte/SvelteKit:** `svelte` in dependencies, `svelte.config.*`
**Django:** `django` in requirements, `manage.py`, `settings.py`
**FastAPI:** `fastapi` in requirements, `main.py` with `app = FastAPI()`
**Rails:** `Gemfile` with `rails`, `config/routes.rb`
**Express:** `express` in dependencies, no framework-specific config
**Rust/Actix:** `actix-web` in Cargo.toml dependencies
**Go/Gin:** `github.com/gin-gonic/gin` in go.mod

**Database detection:** Look for ORM config (Prisma schema, Django models, ActiveRecord migrations), connection strings in .env.example, database packages in manifest (pg, mysql2, mongoose, sqlalchemy, diesel).

**Auth detection:** Look for auth packages (next-auth, passport, devise, django-allauth), auth-related routes, JWT/session configuration.
