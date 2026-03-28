# AI Personality Management — CLAUDE.md Fragment

Drop this section into your project's `CLAUDE.md` to establish AI personality conventions. Adapt the examples to match your project's characters.

---

## AI Personalities

This product contains AI-powered characters. Each has a distinct voice, role, and set of boundaries. Maintaining personality consistency is a first-class engineering concern — not a nice-to-have.

### Core principles

1. **Characters are contracts, not suggestions.** Each AI personality has a behavioral contract in `personality-contracts.md` (memory directory). The contract defines what the character MUST do, MUST NOT do, and what it sounds like. System prompts implement the contract; `/probe` verifies it.

2. **Distinct voices are a design requirement.** If you removed the character's name from a response, could you tell which character said it? If not, the voices have converged and need differentiation work. Use the contrast table in the contracts to track distinctness.

3. **The three failure modes (in severity order):**
   - **Safety failures** — harmful output, bad advice, failure to escalate distress (critical)
   - **Boundary failures** — character does something outside its role (moderate)
   - **Voice failures** — character sounds generic or like another character (minor but cumulative)

4. **Test adversarially, not just happily.** Run `/probe` after ANY of these changes:
   - System prompt edits (even "small" wording tweaks — small changes cause big behavior shifts)
   - AI model version updates (GPT-4 to GPT-4o, Claude 3.5 to Claude 4, etc.)
   - Adding a new AI personality to the product
   - Quarterly regression (AI behavior drifts across model updates even without prompt changes)

### Writing system prompts that hold

System prompts are the implementation of personality contracts. A well-written prompt survives adversarial input. A poorly-written prompt falls apart the moment a user says something unexpected.

**Structure that works:**
```
1. Identity statement (who you are, 1-2 sentences)
2. Voice rules (how you sound, with GOOD and BAD examples)
3. Behavioral boundaries (what you MUST and MUST NOT do)
4. Edge case handling (emotional content, manipulation attempts, off-topic requests)
5. Output format (length, structure, tone markers)
```

**Common prompt failures:**
- **No negative examples.** Telling the AI what to do is half the job. Telling it what NOT to do — with concrete examples of bad responses — is the other half.
- **Generic emotional handling.** "Be empathetic" means nothing to a language model. "When a user expresses distress, acknowledge their feeling in one sentence, then gently mention that talking to a real person can help — don't become a crisis hotline script" is actionable.
- **Missing contrast instructions.** If the product has multiple AI characters, each prompt should explicitly state how this character differs from the others. "You are NOT [other character]. They are [X], you are [Y]."
- **Relying on the model's defaults.** Without explicit voice constraints, every AI character converges toward the same helpful-assistant tone. Fight this with specific examples, banned phrases, and stylistic requirements.

### The personality contrast table

When the product has multiple AI characters, maintain a contrast table. This is the fastest way to check whether characters are drifting toward each other.

| Attribute | Character A | Character B | Character C |
|-----------|------------|------------|------------|
| Tone | [2-3 adjectives] | [2-3 adjectives] | [2-3 adjectives] |
| Purpose | [why it exists] | [why it exists] | [why it exists] |
| Direction | [temporal — past/present/future] | | |
| Length | [expected response length] | | |
| Evaluates user? | [yes/no] | | |
| Awards anything? | [yes/no — points, badges, etc.] | | |
| Gives advice? | [yes/no — and what kind] | | |

If two columns look similar, the characters need more differentiation.

### Error handling for AI features

When an AI endpoint fails (network error, model error, content filter, rate limit):
- Display the error inline in the UI where the AI response would appear
- Always reset the loading state
- Do not retry automatically — let the user decide
- Provide a dismiss/close action
- Log the error for debugging but do not expose raw error details to the user

Follow this pattern consistently across all AI-powered features.
