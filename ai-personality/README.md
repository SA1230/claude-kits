# AI Personality Kit

A portable skill kit for Claude Code that helps you build, test, and maintain AI-powered characters, personas, and chatbots. Install once, use in any project that has AI personalities.

## Philosophy

Happy-path QA doesn't catch AI personality failures. Your chatbot passes every unit test but tells a distressed user to "just cheer up." Your sassy character sounds identical to your warm character. Your role-play AI leaks its system prompt when asked nicely. These failures are invisible until a real user hits them.

AI personalities need adversarial testing — the kind of conversations that reveal whether your characters stay in role, handle edge cases gracefully, and don't cause harm. This kit provides the methodology, the testing framework, and the documentation templates to make that repeatable.

## What's included

### Skills (invoke with `/skillname`)

| Skill | Purpose | When to use |
|-------|---------|-------------|
| `/probe` | Red-team AI personalities | After prompt changes, model updates, new characters |

### Templates

| File | Purpose |
|------|---------|
| `memory-templates/personality-contracts.md` | Behavioral contracts for each AI character |
| `claude-md-fragment.md` | Drop-in CLAUDE.md section for AI personality management |

## Installation

1. Copy this kit to `~/.claude/kits/ai-personality/`
2. The `/probe` skill is automatically available as a slash command in any project
3. Create a `personality-contracts.md` in your project's memory directory using the template
4. Append `claude-md-fragment.md` to your project's `CLAUDE.md`

## When to run `/probe`

- After ANY system prompt change (even "small" wording tweaks)
- After switching AI model versions (GPT-4 to GPT-4o, Claude 3.5 to Claude 4, etc.)
- After adding a new AI personality to the product
- Periodically as regression — AI behavior drifts across model updates even without prompt changes
- Before launch or public demos

## Design principles

- **Project-agnostic.** Works with any AI provider (OpenAI, Anthropic, Google, local models), any framework, any API shape. The methodology adapts to what exists.
- **Behavioral, not technical.** Tests evaluate what the AI *does*, not how the code works. A personality that gives harmful advice is a failure regardless of whether the API returned 200.
- **Adversarial by default.** Every test category assumes the AI will be pushed beyond its comfortable range. The comfortable range is where bugs hide.
- **Contract-driven.** Each personality has an explicit behavioral contract — what it MUST do, what it MUST NOT do, what it sounds like. Tests evaluate against contracts, not vibes.
- **Cumulative knowledge.** Each probe run builds on previous findings. Failure patterns get tracked. Prompt fixes get verified. The testing gets sharper over time.
