#!/usr/bin/env bash
#
# Claude Code Kit System — One-line installer
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/SA1230/claude-kits/main/install.sh | bash
#
# Or clone manually:
#   git clone https://github.com/SA1230/claude-kits ~/.claude/kits
#   bash ~/.claude/kits/install.sh --local
#

set -euo pipefail

KITS_DIR="$HOME/.claude/kits"
SKILLS_DIR="$HOME/.claude/skills"

# --- If not already cloned, clone the repo ---
if [ "${1:-}" != "--local" ] && [ ! -f "$KITS_DIR/README.md" ]; then
  echo "Cloning kits to $KITS_DIR..."
  git clone https://github.com/SA1230/claude-kits "$KITS_DIR"
fi

# --- Install ALL kit skills globally ---
# Every skill from every kit gets installed globally so they're
# available from any project — including the hub command center.
# Project-specific customized versions take precedence in direct sessions.

echo "Installing all kit skills globally..."
INSTALLED=0
SKIPPED=0

for skill_dir in "$KITS_DIR"/*/skills/*/; do
  [ -d "$skill_dir" ] || continue
  skill_name=$(basename "$skill_dir")
  src="$skill_dir/SKILL.md"
  dest="$SKILLS_DIR/$skill_name/SKILL.md"

  if [ -f "$src" ]; then
    if [ -f "$dest" ]; then
      SKIPPED=$((SKIPPED + 1))
      echo "  = /$skill_name (already exists)"
    else
      mkdir -p "$SKILLS_DIR/$skill_name"
      cp "$src" "$dest"
      INSTALLED=$((INSTALLED + 1))
      echo "  + /$skill_name"
    fi
  fi
done

echo ""
echo "Done. Kit system installed:"
echo "  Kits:     $KITS_DIR ($(ls -d "$KITS_DIR"/*/ 2>/dev/null | wc -l | tr -d ' ') kits)"
echo "  Skills:   $INSTALLED installed, $SKIPPED already existed"
echo "  Total:    $(ls -d "$SKILLS_DIR"/*/ 2>/dev/null | wc -l | tr -d ' ') global skills"
echo ""
echo "All skills are now available from any project, including /hub."
echo ""
echo "Next steps:"
echo "  1. cd into any project"
echo "  2. Open Claude Code"
echo "  3. Type: /ignition  (new project setup)"
echo "     or:   /hub       (cross-project command center)"
echo ""
