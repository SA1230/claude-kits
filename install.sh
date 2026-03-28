#!/usr/bin/env bash
#
# Claude Code Kit System — One-line installer
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/YOUR_USER/claude-kits/main/install.sh | bash
#
# Or clone manually:
#   git clone https://github.com/YOUR_USER/claude-kits ~/.claude/kits
#   bash ~/.claude/kits/install.sh --local
#

set -euo pipefail

KITS_DIR="$HOME/.claude/kits"
SKILLS_DIR="$HOME/.claude/skills"

# --- If not already cloned, clone the repo ---
if [ "${1:-}" != "--local" ] && [ ! -f "$KITS_DIR/README.md" ]; then
  echo "Cloning kits to $KITS_DIR..."
  git clone https://github.com/YOUR_USER/claude-kits "$KITS_DIR"
fi

# --- Install global bootstrapping skills ---
echo "Installing global skills..."
BOOTSTRAP_SKILLS="ignition bootstrap scaffold install-kit port"

for skill in $BOOTSTRAP_SKILLS; do
  src="$KITS_DIR/cold-start-killer/skills/$skill/SKILL.md"
  dest="$SKILLS_DIR/$skill/SKILL.md"

  if [ -f "$src" ]; then
    mkdir -p "$SKILLS_DIR/$skill"
    cp "$src" "$dest"
    echo "  ✓ /$skill"
  else
    echo "  ✗ /$skill (not found in kits)"
  fi
done

echo ""
echo "Done. Kit system installed:"
echo "  Kits:   $KITS_DIR ($(ls -d "$KITS_DIR"/*/  2>/dev/null | wc -l | tr -d ' ') kits)"
echo "  Skills: $SKILLS_DIR ($(echo $BOOTSTRAP_SKILLS | wc -w | tr -d ' ') global skills)"
echo ""
echo "Next steps:"
echo "  1. cd into any project"
echo "  2. Open Claude Code"
echo "  3. Type: /ignition"
echo ""
