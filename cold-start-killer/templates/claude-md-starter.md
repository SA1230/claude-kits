# CLAUDE.md

## What this project is

[1-2 sentences: what this project does and who it is for. Be specific -- "a habit tracker that gamifies daily activities" is better than "a web application."]

## Tech stack

- **Framework:** [e.g., Next.js 15 (App Router), Django 5, Rails 7, etc.]
- **Language:** [e.g., TypeScript, Python 3.12, Ruby 3.3]
- **Styling:** [e.g., Tailwind CSS 4, CSS Modules, styled-components, or "none"]
- **Database:** [e.g., PostgreSQL via Supabase, SQLite, MongoDB, or "none"]
- **Auth:** [e.g., NextAuth v5 with Google OAuth, Django auth, Devise, or "none"]
- **Hosting:** [e.g., Vercel, Railway, Fly.io, self-hosted, or "TBD"]
- **Testing:** [e.g., Vitest, pytest, RSpec, or "none yet"]
- **Linting:** [e.g., ESLint + Prettier, Ruff, RuboCop, or "none"]

## Project structure

```
[Indented directory tree with one-line descriptions for key directories and files.
Only include directories that matter -- skip node_modules, .git, build output, etc.
Example:

src/
  app/           # Next.js App Router pages and layouts
  components/    # Reusable React components
  lib/           # Shared utilities, types, and business logic
public/          # Static assets
]
```

## Data model

[Key types and their relationships. Focus on the domain model, not framework types.
Example:

- **User** -- authenticated user with profile data
- **Activity** -- one logged action with stat, note, timestamp, and XP amount
- **GameData** -- root state object stored per user (stats, activities, settings)

If using a typed language, reference the file where types are defined.]

## Key patterns

[How data flows through the application. 3-5 bullet points covering:
- State management approach (context, Redux, localStorage, server state, etc.)
- Data fetching pattern (server components, API routes, tRPC, etc.)
- Error handling convention (error boundaries, try/catch, toast notifications, etc.)
- Mutation pattern (how writes happen -- form actions, API calls, optimistic updates, etc.)
- Any project-specific conventions that a new contributor would need to know]

## Key commands

```bash
[dev command]     # Start dev server (e.g., npm run dev)
[build command]   # Production build (e.g., npm run build)
[test command]    # Run tests (e.g., npx vitest run)
[lint command]    # Check code quality (e.g., npm run lint)
```

## How to work with me

[Project-specific working conventions. Reference ~/.claude/CLAUDE.md for universal preferences rather than duplicating them here. Only add rules that are specific to THIS project.

Examples of project-specific rules:
- "Match the patterns already in the codebase. Do not introduce new patterns without discussing first."
- "All state flows through GameData loaded from localStorage. Do not add a state management library."
- "This is a mobile-first app. Do not add desktop breakpoints unless asked."
- "Keep CLAUDE.md accurate after structural changes."]

## Known issues

[Document product-level issues here as they surface. Reference this section when working on related features.

Example:
- Calendar shows full 31-day grid but early in the month most cells are empty. Looks barren for new users.
- Auth redirect sometimes loses the return URL on mobile Safari.]

## Infrastructure

[CI, hosting, MCP tools, plugins, and other development infrastructure.

Example:
- **CI:** GitHub Actions -- lint + build + test on every PR
- **Hosting:** Vercel (production) -- auto-deploys from main
- **Pre-push hook:** .claude/hooks/pre-push-gate.sh blocks pushes that fail quality gates
- **Dev server:** .claude/launch.json configures npm run dev on port 3000
- **Connected services:** Supabase (database), Vercel (hosting), GitHub (repo)]
