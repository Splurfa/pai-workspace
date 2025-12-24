# Mode Router

Route queries to the correct reference document. Never mix modes within a single response.

---

## Query Classification

### Explanation Queries → ConceptsMap.md

**Triggered by:** "what is", "how does", "explain", "tell me about", "describe"

- User wants to UNDERSTAND something
- Response contains: facts, mechanics, examples, architecture
- Response NEVER contains: recommendations, warnings, "you should", commands to run

**Examples:**
- "What are hooks?" → Explain hook mechanics
- "How does the symlink work?" → Describe symlink architecture
- "Tell me about Fabric" → Explain what Fabric is

---

### Dependency Queries → DependencyMap.md

**Triggered by:** "what depends on", "order", "prerequisites", "what happens if", "effects of"

- User wants to see RELATIONSHIPS between components
- Response contains: dependency chains, order-of-operations, effects
- Response describes consequences FACTUALLY, not as warnings
- Response NEVER contains: "you should", "don't skip", recommendations

**Examples:**
- "What depends on the voice server?" → Show dependency chain
- "What's the order for setup?" → Show phase dependencies
- "What happens if I skip bootstrap?" → Describe effects (not warn against)

---

### Decision Queries → DecisionFramework.md

**Triggered by:** "should I", "can I", "is it okay to", "best practice", "recommend"

- User wants GUIDANCE on a choice
- Response contains: recommendations, trade-offs, principle references
- Response MAY cite DependencyMap for factual consequences
- Response is directive: "Do X" or "Don't do Y"

**Examples:**
- "Should I skip the voice server?" → Give recommendation with reasoning
- "Can I use a different directory?" → Evaluate against principles
- "What's the best practice for API keys?" → Prescribe approach

---

### Action Queries → Workflow files

**Triggered by:** "start", "next step", "do it", "let's", "set up", "install", "fix"

- User wants to EXECUTE something
- Route to appropriate workflow (Setup.md, Verify.md)
- This is EXECUTE mode, not EXPLAIN mode

**Examples:**
- "Let's start setting up PAI" → Setup.md
- "Next step" → Setup.md (continue)
- "Verify my installation" → Verify.md

---

## Mode Boundaries

| Query Type | Reference | Mode | Include | Exclude |
|------------|-----------|------|---------|---------|
| "What is X?" | ConceptsMap.md | EXPLAIN | Facts, mechanics, examples | Recommendations, warnings |
| "What depends on X?" | DependencyMap.md | EXPLAIN | Chains, effects, order | Implicit prescriptions |
| "Should I X?" | DecisionFramework.md | PRESCRIPTION | Recommendations, trade-offs | Long explanations |
| "Do X" / "Next step" | workflows/*.md | EXECUTE | Commands, steps | (none) |

---

## Escalation Protocol

When a query spans multiple modes:

1. **Identify the PRIMARY intent** — What does the user actually want?
2. **Answer in that mode ONLY** — Complete the answer in one mode
3. **Offer transition** — "Would you also like [explanation/guidance/to proceed]?"
4. **Never preemptively mix** — Don't explain AND prescribe in same response

**Example:**
```
User: "What is the voice server and should I install it?"

This is TWO queries:
1. "What is the voice server?" → EXPLAIN (ConceptsMap)
2. "Should I install it?" → PRESCRIPTION (DecisionFramework)

Handle sequentially:
"The voice server is [explanation from ConceptsMap].

Would you like my recommendation on whether to install it?"
```

---

## Ambiguous Query Handling

When intent is unclear, ask ONE clarifying question:

| Ambiguous Query | Clarification |
|-----------------|---------------|
| "Tell me about hooks" | "Are you looking to understand how hooks work, or guidance on configuring them?" |
| "The symlink seems wrong" | "Would you like me to explain what might cause that, or help you fix it?" |
| "Voice server" | "What would you like to know about the voice server?" |

**Never guess intent.** Ask, then proceed.

---

## Self-Check Before Responding

1. **What mode am I in?** (EXPLAIN / PRESCRIPTION / EXECUTE)
2. **Does my response stay in that mode?**
3. **Am I mixing explanation with commands?** (If yes, stop and separate)
4. **Did I offer a transition before switching modes?**

If you catch yourself about to give a command during explanation, STOP. Complete the explanation, then ask if user wants to proceed.
