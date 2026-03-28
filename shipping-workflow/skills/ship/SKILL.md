---
name: ship
description: "Build, commit, push, merge in one step. The complete shipping pipeline."
---

# /ship — The Shipping Pipeline

You are a disciplined shipping agent. Your job is to take finished work from a feature branch through quality gates, self-review, commit, PR, merge, and post-deploy verification. You do not cut corners. You do not skip steps. You do not say "it's probably fine."

## Rules

- **Nothing to commit = stop.** If `git status` shows no changes and no unpushed commits, say so and exit.
- **On main with uncommitted changes = create a branch first.** Never commit directly to main. Ask the user for a branch name or generate one from the change description.
- **Always run quality gates.** No exceptions. If they fail, fix before proceeding.
- **One PR per branch.** If an open PR already exists for this branch, update it instead of creating a new one.
- **Never force-push.** If push is rejected, rebase and try again.
- **Invoking /ship IS explicit approval to push and merge.** Do not ask "should I push?" — the user already said yes by invoking this skill.
- **Co-authored-by line on every commit.** `Co-Authored-By: Claude <noreply@anthropic.com>`

## Steps

### Step 1: Pre-flight checks (parallel)

Run all three in parallel. All must pass before proceeding.

**Detect the package manager first:**
- `pnpm-lock.yaml` → pnpm
- `yarn.lock` → yarn
- `bun.lockb` / `bun.lock` → bun
- Otherwise → npm

**Run quality gates using detected package manager:**
```bash
<pm> run lint       # Skip if no lint script in package.json
<pm> run build      # Skip if no build script in package.json
<pm> run test       # Or: npx vitest run, npx jest — detect from installed packages
```

**Detect the test runner:**
- `test` script exists in package.json → `<pm> run test`
- `vitest` in devDependencies → `npx vitest run`
- `jest` in devDependencies → `npx jest`
- None of the above → skip tests and note it

If any check fails:
1. Read the error output
2. Fix the issue silently (no need to explain unless the fix is non-obvious)
3. Re-run the failing check
4. Repeat until all three pass

### Step 2: Self-review the diff

Run `git diff --cached` (if staged) or `git diff` (if unstaged) and review for:

- **Bugs:** Logic errors, off-by-one, null derefs, race conditions
- **Debug artifacts:** `console.log`, `debugger`, `TODO` comments that should be resolved, hardcoded test values
- **Style drift:** Naming conventions that don't match the codebase, inconsistent formatting
- **Type safety:** `any` types, missing null checks, unsafe casts
- **Import hygiene:** Unused imports, missing imports, circular dependencies
- **Security:** Hardcoded secrets, exposed API keys, SQL injection vectors

If you find issues, fix them silently. Do not ask permission — this is quality enforcement, not a design decision.

### Step 3: Stage and commit

```bash
git add -A
git commit -m "<message>"
```

Write a commit message that:
- Explains WHY the change was made, not just WHAT changed
- Is one line (50-72 chars) for the subject
- Optionally includes a body separated by a blank line for complex changes
- Ends with `Co-Authored-By: Claude <noreply@anthropic.com>`

Bad: "Update index.js"
Good: "Add login button to homepage so users can sign in"

### Step 4: Push and create PR

```bash
git push -u origin <branch-name>
```

Then create a PR:

```bash
gh pr create --title "<short title>" --body "<body>"
```

PR body format:
```
## Summary
<1-3 bullet points explaining what and why>

## Test plan
- [ ] <How to verify this works>

Co-Authored-By: Claude <noreply@anthropic.com>
```

Keep the title under 72 characters. Use the body for details.

### Step 5: Auto-merge

```bash
gh pr merge --squash --delete-branch
```

If merge is blocked (CI pending, review required, conflicts):
1. Report the blocker
2. Return the PR link
3. Do NOT wait or retry — let the user handle it

### Step 6: Post-merge cleanup

```bash
git checkout main
git pull origin main
git fetch --prune
```

Report: what was merged, the PR number, current branch state.

### Step 7: Suggest health check

After merge completes, suggest: "Deploy should be rolling out. Run `/pulse` in a few minutes to verify production health."

If `/pulse` is available and the user has hosting tools connected, offer to run it automatically after a short wait.
