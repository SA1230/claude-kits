# Decision Framework

Paste this section into any project's `CLAUDE.md` to encode product thinking habits into your development workflow.

---

## Decision Framework

When a new feature is proposed -- especially one that takes more than a couple of hours -- follow this thinking before building:

1. **Frame it as a thesis.** Every feature is a bet: "If we build X, then Y will happen, because Z." If the thesis is not clear, help articulate it before writing code. Most features skip the "because Z" part entirely -- that is the most important part.

2. **Ask "who is this for?"** Is this for the founder (a taste call), current users (a retention bet), or hypothetical future users (a growth bet)? All three are valid, but the implications are different. Building for hypothetical users is the riskiest bet because you are guessing who they are.

3. **Flag untestable bets.** If there is no way to measure whether a feature worked -- no analytics, no observable behavior change, no data -- say so. An untestable thesis is a bet you can never learn from. This is especially important when the data layer is still being built.

4. **Consider the cheapest test.** Before building the full version, is there a 10%-effort version that provides 80% of the signal? A partial build, a manual simulation, a mockup, or even just asking users? The goal is to validate the thesis before committing to the full scope.

5. **Name the opportunity cost.** Building X means not building Y. Always consider: is this the best use of the next bet? This question is uncomfortable but necessary -- it prevents "yes, and" syndrome where every idea gets built because no idea gets compared.

For small features and bug fixes, skip this. For big bets that take a session or more, run `/thesis` to formalize the examination. If the thesis survives, run `/devil` to find failure modes before committing.
