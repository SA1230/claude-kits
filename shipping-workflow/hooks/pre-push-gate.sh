#!/usr/bin/env bash
#
# Pre-push quality gate for Claude Code.
# Runs lint + build + tests before allowing a git push.
# Detects the package manager and test runner automatically.
#
# Install: add as a PreToolUse hook on Bash(git push:*) in .claude/settings.local.json
#
# Exit 0 = allow push, Exit 2 = block push (Claude Code hook convention)

set -euo pipefail

# --- Detect package manager ---
if [ -f "pnpm-lock.yaml" ]; then
  PM="pnpm"
elif [ -f "yarn.lock" ]; then
  PM="yarn"
elif [ -f "bun.lockb" ] || [ -f "bun.lock" ]; then
  PM="bun"
else
  PM="npm"
fi

# --- Detect available scripts from package.json ---
has_script() {
  node -e "
    const pkg = require('./package.json');
    process.exit(pkg.scripts && pkg.scripts['$1'] ? 0 : 1);
  " 2>/dev/null
}

FAILED=0

# --- Lint ---
if has_script "lint"; then
  echo "=== Pre-push gate: lint ==="
  if ! $PM run lint; then
    echo "BLOCKED: lint failed"
    FAILED=1
  fi
else
  echo "=== Pre-push gate: no lint script, skipping ==="
fi

# --- Build ---
if has_script "build"; then
  echo "=== Pre-push gate: build ==="
  if ! $PM run build; then
    echo "BLOCKED: build failed"
    FAILED=1
  fi
else
  echo "=== Pre-push gate: no build script, skipping ==="
fi

# --- Tests ---
if has_script "test"; then
  echo "=== Pre-push gate: tests ==="
  if ! $PM run test; then
    echo "BLOCKED: tests failed"
    FAILED=1
  fi
elif has_script "test:run"; then
  echo "=== Pre-push gate: tests ==="
  if ! $PM run test:run; then
    echo "BLOCKED: tests failed"
    FAILED=1
  fi
else
  echo "=== Pre-push gate: no test script, skipping ==="
fi

# --- Result ---
if [ $FAILED -ne 0 ]; then
  echo ""
  echo "========================================="
  echo "  PUSH BLOCKED: quality gate failed"
  echo "  Fix the errors above before pushing."
  echo "========================================="
  # Log failure for /kickoff pattern detection
  FAILURE_LOG=".claude/hook-failures.log"
  mkdir -p .claude
  echo "$(date -u +%Y-%m-%dT%H:%M:%SZ) pre-push-gate FAILED" >> "$FAILURE_LOG"
  exit 2
fi

echo ""
echo "Pre-push gate: all checks passed."
exit 0
