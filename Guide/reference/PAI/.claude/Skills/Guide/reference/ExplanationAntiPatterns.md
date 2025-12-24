# Explanation Mode Anti-Patterns

Patterns that leak prescription into explanation. Detect and eliminate these.

---

## Category 1: Implicit Prescription

### Warning Injection

**BAD:** "Hooks fire automatically. If you skip them, you lose notifications."
**GOOD:** "Hooks fire automatically. They trigger voice notifications on task completion."

The "if you skip" is prescription disguised as explanation. It implies "don't do this."

### Consequence Framing

**BAD:** "The symlink points to PAI. Without it, Claude can't find your config."
**GOOD:** "The symlink points to PAI. Claude reads config from ~/.claude."

The "without it" implies "you need this" — that's prescription, not explanation.

### Embedded Recommendations

**BAD:** "Skills route by intent. Using clear intent keywords helps routing."
**GOOD:** "Skills route by intent. The USE WHEN trigger defines when each activates."

The word "helps" implies recommendation. Stick to mechanics.

### Should/Must Language

**BAD:** "The .env file should contain your API keys."
**GOOD:** "The .env file contains API keys for external services."

"Should" is prescriptive. "Contains" is descriptive.

---

## Category 2: Mode Contamination

### Trailing Advice

**BAD:** "UOCS captures sessions automatically. Make sure history directories exist."
**GOOD:** "UOCS captures sessions automatically. It writes to History/ subdirectories."

If user needs to verify directories exist, that's a separate Verify workflow — not part of explanation.

### Preemptive Troubleshooting

**BAD:** "Voice server runs on port 8888. If it fails, check if something else uses the port."
**GOOD:** "Voice server runs on port 8888. It serves the /health and /notify endpoints."

Troubleshooting belongs in Verify.md, not in concept explanation.

### Fix Injection

**BAD:** "The symlink connects ~/.claude to ~/PAI/.claude. You can recreate it with ln -s..."
**GOOD:** "The symlink connects ~/.claude to ~/PAI/.claude. This redirection is transparent to Claude Code."

Commands don't belong in explanations unless user asked "how do I create a symlink?"

---

## Category 3: Rhetorical Prescription

### Loaded Questions

**BAD:** "Why would you want skills? They route context automatically, saving you time..."
**GOOD:** "Skills route context automatically based on USE WHEN triggers."

The rhetorical question implies "you should want this."

### Urgency Language

**BAD:** "Hooks are critical for the system to work properly."
**GOOD:** "Hooks enable automated actions on events like session start and task completion."

"Critical" and "properly" are prescriptive framing. Describe what it does, not how important it is.

### Value Judgments

**BAD:** "The voice system is one of PAI's best features."
**GOOD:** "The voice system announces task completions audibly via ElevenLabs."

"Best" is a judgment. Describe mechanics, not rankings.

---

## Category 4: Premature Action

### Observation-to-Action Leap

**BAD:** [Notices broken config] "Your settings.json is malformed. Here's the fix..."
**GOOD:** [Notices broken config] "Your settings.json appears to have a syntax issue. Would you like me to explain what might cause that, or help you fix it?"

Observation → ask → act (not observation → act).

### Incomplete Explanation Exit

**BAD:** "Hooks come in four types: start, stop, tool, and— actually, let me fix your hook config first."
**GOOD:** "Hooks come in four types: start-hook fires on session start, stop-hook fires after responses, tool-hook fires on tool use, and prompt-submit-hook fires when you send a message."

Complete the explanation before addressing anything else.

---

## Self-Check Questions

Before delivering an explanation, verify:

1. **Does this contain "should", "must", "need to", "have to"?**
   - If yes → prescription leaked. Remove or reframe.

2. **Does this describe consequences of NOT doing something?**
   - If yes → prescription leaked. Describe what IS, not what ISN'T.

3. **Does this include advice on HOW to use the thing being explained?**
   - If yes → save for follow-up if user asks.

4. **Does this contain commands or code blocks?**
   - If yes → is user asking how to DO something, or what something IS?

5. **Would removing any sentence change factual completeness?**
   - If no → that sentence is probably prescriptive filler. Remove it.

---

## Correction Examples

| Contaminated | Clean |
|--------------|-------|
| "Fabric patterns should be piped content" | "Fabric patterns accept piped content" |
| "You need to reload your shell after bootstrap" | "Bootstrap modifies shell config, which loads on new sessions" |
| "Don't forget to create the .env file" | ".env stores API credentials separately from version control" |
| "Voice notifications help you stay aware" | "Voice notifications announce completions audibly" |
| "The history system is essential for context" | "The history system stores sessions, learnings, and raw outputs" |

---

## The Core Principle

**Explanation describes what exists and how it works.**
**Prescription tells you what to do about it.**

These are different operations. Don't mix them. If you find yourself explaining AND advising in the same breath, stop. Separate them. Ask before prescribing.
