# Explain Workflow

Deep-dive explanations of PAI concepts with concrete examples.

---

## Process

1. Identify the concept being asked about
2. Find relevant file(s) in `../PAI-reference/`
3. Read the authoritative documentation
4. Explain in plain language with examples
5. Connect to user's current progress
6. Note dependencies and implications

---

## Key Concepts Map

### Architecture & Philosophy
- **13 Principles** → `PAI-reference/.claude/Skills/CORE/CONSTITUTION.md`
- **Why scaffolding matters** → CONSTITUTION.md Part I
- **Deterministic vs probabilistic** → Principle 3

### The Four Primitives
- **Skills** → `PAI-reference/.claude/Skills/CORE/SkillSystem.md`
- **Agents** → `PAI-reference/.claude/Agents/*.md`
- **Hooks** → `PAI-reference/.claude/Skills/CORE/HookSystem.md`
- **Commands** → `PAI-reference/.claude/Commands/`

### Systems
- **UOCS/History** → `PAI-reference/.claude/Skills/CORE/HistorySystem.md`
- **Voice** → `PAI-reference/.claude/voice-server/README.md`
- **MCP** → `PAI-reference/.claude/.mcp.json`
- **Fabric** → `PAI-reference/.claude/Skills/Fabric/`

---

## Explanation Format

### 1. What It Is (1-2 sentences)
Plain language definition.

### 2. Why It Exists (the problem it solves)
Connect to a PAI principle if relevant.

### 3. How It Works (mechanics)
Concrete explanation with file references.

### 4. Example (real usage)
Show actual use case.

### 5. Dependencies (what it connects to)
- What it requires
- What requires it
- 2nd/3rd order effects

### 6. Relevance to You (connection to progress)
How this relates to their current setup phase.

---

## Common Questions

### "What are skills?"
Self-contained AI capabilities. Like apps on your phone — each does one domain well. Activated by USE WHEN triggers in natural language.

### "What are hooks?"
Event listeners. When something happens (session starts, task completes), hooks fire automatically. They power voice notifications and history capture.

### "What is UOCS?"
Universal Output Capture System. Auto-documentation of everything you do. Sessions, learnings, decisions — all captured without manual effort.

### "What is Fabric?"
Daniel Miessler's prompt library. 242 patterns, each solving one problem perfectly. UNIX philosophy for prompts.

### "What are agents?"
Specialized AI personalities. Engineer writes code, Researcher investigates, Architect designs systems. Each has its own voice and expertise.

### "Why the 13 principles?"
They're the foundation. Every architectural decision traces back to them. Understanding them = understanding why PAI works the way it does.
