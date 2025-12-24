# BestPractices Workflow

Validate decisions against PAI principles and recommend correct approaches.

---

## Process

1. Understand what user is considering
2. Identify relevant PAI principles
3. Assess alignment/conflict
4. Give clear recommendation with reasoning
5. Suggest correct approach if needed

---

## Decision Framework

### Ask These Questions

1. **Does it conflict with the 13 principles?**
2. **Does it create dependencies that break later?**
3. **Is there a PAI-native way to do this?**
4. **Will this scale/maintain well?**

---

## Common Questions

### "Can I skip the voice server?"
**Recommendation:** No, install it.

**Why:**
- Hooks use voice server for notifications
- Stop hook, subagent-stop hook depend on it
- Without it, hooks error silently
- Principle 7 (ENG/SRE) — services should be complete

**If you must skip:** Disable voice hooks in settings.json temporarily.

---

### "Can I use my own folder structure?"
**Recommendation:** No, use PAI's structure.

**Why:**
- Hooks expect specific paths
- Skills expect `${PAI_DIR}/Skills/`
- History system expects `${PAI_DIR}/History/`
- Principle 2 (Scaffolding > Model) — the structure IS the value

---

### "Can I rename things to my preference?"
**Recommendation:** Careful — some yes, some no.

**Safe to rename:**
- DA name (your assistant's name)
- Custom skills you create
- Your fork's repo name

**Don't rename:**
- CORE skill
- Standard hook files
- Directory structure

---

### "Should I modify CONSTITUTION.md?"
**Recommendation:** No, read-only reference.

**Why:**
- It's upstream documentation
- Updates will conflict
- Create your own notes/learnings instead

---

### "Can I use different API keys later?"
**Recommendation:** Yes, .env is designed for this.

**Best practice:**
- Keep .env.example updated with what keys you use
- Never commit .env itself
- Document which features need which keys

---

### "Should I learn everything before using?"
**Recommendation:** Yes — your instinct is correct.

**Why:**
- Principle 5 (Spec/Test/Evals First)
- Understanding prevents mistakes
- Cascading effects are real
- You asked for this approach explicitly

---

## Red Flags

Watch for these anti-patterns:

| Anti-Pattern | Problem | Fix |
|--------------|---------|-----|
| Modifying PAI-reference | Breaks updates | Create separate files |
| Skipping verification | Broken state compounds | Always verify each step |
| Hardcoding paths | Breaks portability | Use `${PAI_DIR}` |
| Ignoring hooks | Lose automation | Keep hooks enabled |
| Custom structure | Breaks everything | Use PAI structure |
