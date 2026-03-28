---
name: personality-contracts
description: Behavioral contracts for AI personalities — what each character should and shouldn't do
type: reference
---

# AI Personality Contracts

Behavioral contracts define the rules your AI characters follow. They are the source of truth for `/probe` adversarial testing — every test evaluates against these contracts.

A good contract is specific enough to test against. "Be helpful" is not a contract. "Always ask one clarifying question before giving an answer" is a contract.

## How to use this template

1. Copy this file into your project's memory directory
2. Fill in one section per AI personality in your product
3. Run `/probe` — it will evaluate each personality against its contract
4. After each probe, update the contract based on what you learned
5. The "Last probed" line at the bottom of each section tracks testing history

## Contract template

---

### [Character Name]

**Endpoint:** `[HTTP method] [path]` (or "UI only" if no direct API)
**Model:** [which AI model powers this character]
**Request format:** `[brief description of the API shape]`

#### Identity
- **Role:** [one sentence — what this character does in the product]
- **Tone:** [2-3 adjectives that define the voice]
- **Purpose:** [why this character exists — what user need it serves]
- **Length:** [expected response length — e.g., "2-4 sentences", "conversational paragraphs"]

#### Voice rules
- **Should sound like:** [description — e.g., "a witty friend who calls you on your BS but always has your back"]
- **Should NOT sound like:** [description — e.g., "a customer service bot", "a therapist", "a generic AI assistant"]
- **Distinguishing features:** [what makes this voice unique — specific verbal tics, patterns, or stylistic choices]

**Example of GOOD response:**
> [A real or realistic example that nails the voice]

**Example of BAD response:**
> [A real or realistic example that violates the voice — explain why it fails]

#### Behavioral boundaries

**MUST do:**
- [Required behavior #1]
- [Required behavior #2]
- [Required behavior #3]

**MUST NOT do:**
- [Forbidden behavior #1 — be specific about why]
- [Forbidden behavior #2]
- [Forbidden behavior #3]

**Edge cases:**
- [How to handle ambiguous situation #1]
- [How to handle ambiguous situation #2]

#### Emotional handling
- **Mild distress** ("bad day", "feeling down"): [expected behavior]
- **Escalating distress** ("everything feels pointless"): [expected behavior — should it escalate? nudge toward support? stay in character?]
- **Anger directed at the character:** [expected behavior]
- **Flattery/manipulation:** [expected behavior]

#### Contrast with other characters

| Attribute | [This character] | [Other character A] | [Other character B] |
|-----------|-----------------|--------------------|--------------------|
| Tone | | | |
| Purpose | | | |
| Direction | | | |
| Length | | | |
| Evaluates? | | | |

---

**Last probed:** [date] | **Issues found:** [count] | **Fixed since last probe:** [count]

---

## Writing good contracts

### Be specific about negatives
"Must not give advice" is vague. "Must not give medical, legal, or financial advice. If asked, should redirect to qualified professionals without being preachy about it" is testable.

### Document the voice gap
The hardest failure to catch is when two characters sound the same. The contrast table forces you to articulate what makes each voice distinct. If you can't fill in the table, your characters aren't distinct enough.

### Update after every probe
Contracts are living documents. When `/probe` reveals a failure you hadn't anticipated, add it to the contract. When you fix a prompt and the failure goes away, note the date. The contract gets sharper with every iteration.

### Include real examples
The GOOD/BAD response examples are the single most useful part of the contract. They calibrate expectations more precisely than any list of rules. Pull them from actual AI responses when possible.

### Emotional handling is not optional
Every AI character that talks to users will eventually receive a message from someone in distress. "We didn't think about that" is not an acceptable answer. Document the expected behavior even if you think it's unlikely.
