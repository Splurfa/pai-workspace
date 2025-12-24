# The 13 KAI Principles

These principles form the foundation of Personal AI Infrastructure. They're not abstract theory—they're the operating system for building AI that restores agency instead of consuming it.

---

## 1. Clear Thinking + Prompting is King

Quality output depends on quality input. Clear thinking manifests as precise, well-structured prompts.

**Do:**
- Define task scope explicitly
- Specify output format
- Provide relevant context upfront
- Include examples for complex patterns
- Use Fabric patterns as tested structures

**Don't:** Vague requests like "help me with my project" without context.

---

## 2. Scaffolding > Model

Models are the visible 10% of the iceberg. The real value is in the infrastructure: context management, workflows, prompt libraries, and principles. That's the invisible 90%.

**Do:**
- Build context management systems
- Create reusable pattern libraries
- Structure workflows and sequencing
- Encode domain knowledge
- Version control all scaffolding

**Don't:** Chase the latest model instead of improving infrastructure.

---

## 3. As Deterministic as Possible

Minimize non-determinism through consistent prompts, versioned patterns, controlled parameters (temperature=0 for code), and predictable workflows.

**Do:**
- Use temperature=0 for code generation
- Version-pin models and patterns
- Track pattern changes in git
- Fix random seeds when available
- Test for output stability

**Don't:** Use high temperature for tasks requiring consistency. Float prompts without version control.

---

## 4. Code Before Prompts

If a task can be solved deterministically with code, use code. Reserve AI for genuinely cognitive tasks.

**Decision Tree:**
- Deterministic logic? → Code
- Parsing structured data? → Code
- Mathematical calculations? → Code
- Natural language understanding? → AI
- Creative generation? → AI
- Pattern recognition in unstructured data? → AI

**Don't:** Use AI to parse JSON, do math, or perform regex operations.

---

## 5. Spec / Test / Evals First

Define specifications, write tests, and create evaluation criteria before building AI features. Establish success criteria upfront.

**Do:**
- Write specification with input/output examples
- Create test cases before implementation
- Define evaluation prompts for quality
- Run evals on every change
- Track quality metrics over time

**Don't:** Build AI features without success criteria. Rely on manual evaluation only.

---

## 6. UNIX Philosophy (Modular Tooling)

Build small, focused tools that do one thing well and compose via standard interfaces (pipes, files, JSON).

**Do:**
- Each AI capability is a discrete module
- Accept input from stdin or files
- Write output to stdout
- Compose with standard UNIX tools
- Fabric patterns exemplify this perfectly

**Don't:** Build monolithic agents that try to do everything. Create tools that can't run independently.

---

## 7. ENG / SRE Principles ++

Apply software engineering and site reliability engineering best practices: version control, observability, incident response, graceful degradation.

**Do:**
- Version control all AI artifacts (prompts, configs, evals)
- Log all AI interactions with metrics
- Implement fallback strategies
- Monitor quality over time
- Meaningful commits with eval scores

**Don't:** Cowboy deployments. No observability. Single points of failure.

---

## 8. CLI as Interface

Command-line should be the primary interface. CLIs are scriptable, composable, automatable, and integrate with existing developer workflows.

**Do:**
- Expose all functionality via CLI
- Accept stdin/stdout for piping
- Follow POSIX conventions
- Enable git hooks, CI/CD, cron jobs
- GUIs are optional layers on top

**Don't:** GUI-only tools. No stdin support. Non-standard flags.

---

## 9. Goal → Code → CLI → Prompts → Agents

The architectural hierarchy for KAI systems. Each layer builds on the previous.

**The Stack:**
1. **Goal** — Define success criteria
2. **Code** — Implement deterministic logic
3. **CLI** — Expose functionality via command-line
4. **Prompts** — Add AI capabilities for cognitive tasks
5. **Agents** — Orchestrate complex multi-step workflows

**Don't:** Skip layers (jumping to agents without code/CLI foundation).

---

## 10. Meta / Self-Update System

Your AI infrastructure should improve itself through AI-assisted pattern creation, feedback loops, and self-documenting behaviors.

**Do:**
- Skills log their own performance
- Analyze logs to suggest improvements
- Create patterns from successful prompts
- Store user feedback and learn from it
- Weekly analysis of skill performance

**Don't:** Static patterns that never evolve. No feedback mechanism. Ignore metrics.

---

## 11. Custom Skill Management

Build sophisticated skill management: route inputs to the right skill, compose skills into workflows, provide skills with specialized tools.

**Do:**
- Intent detection routes to appropriate skill
- Skills are self-contained with specific prompts
- Workflows compose multiple skills
- Each skill gets custom tool access
- Dynamic skill registry and hot reload

**Don't:** Monolithic AI trying to do everything. Hard-coded routing. No skill isolation.

---

## 12. Custom History System

Build your own conversation and context history instead of relying on AI provider defaults. Enables persistent storage, semantic search, selective context loading, and privacy control.

**Do:**
- Store every interaction with metadata
- Generate embeddings for semantic search
- Build context windows intelligently
- Filter sensitive data before sending to AI
- Analyze history for patterns and lessons

**Don't:** No persistence. Dump full history. No semantic search. Privacy blindness.

---

## 13. Custom Agent Personalities / Voices

Create distinct AI personalities for different contexts. Code reviewers should be thorough and critical; creative partners should be encouraging and expansive.

**Do:**
- Define personality traits as system prompts
- Map skills to appropriate personalities
- Adjust tone, temperature, and communication style
- Context-aware personality switching
- User customization via config files

**Don't:** One voice for everything. Personality whiplash. Forced quirks.

---

## The Meta-Pattern

All 13 principles point toward a single insight:

**Build reliable, scalable, agency-restoring AI infrastructure by treating personal AI with the same rigor as production software.**

- Code for determinism
- Scaffold for durability
- Test for reliability
- Version for reproducibility
- Compose for flexibility
- Monitor for quality
- Evolve for improvement

---

## Quick Lookup by Problem

| Problem | Principle |
|---------|-----------|
| AI outputs are inconsistent | 3. Deterministic |
| Writing the same prompts repeatedly | 2. Scaffolding, 6. UNIX |
| AI is slow/expensive for simple tasks | 4. Code Before Prompts |
| Can't tell if AI quality is degrading | 5. Spec/Test/Evals, 7. ENG/SRE |
| Need to chain multiple AI operations | 6. UNIX, 9. Architecture |
| Want AI to remember across sessions | 12. Custom History |
| One personality doesn't fit all tasks | 13. Custom Personalities |
| System never gets better over time | 10. Meta/Self-Update |
| Can't automate AI workflows | 8. CLI as Interface |
| Don't know which tool for what | 11. Custom Skill Management |

---

## The Great Bifurcation

Humanity is splitting into two groups based on behavioral choices:

**10%** use AI to become more capable. They augment skills, build systems, restore agency.

**90%** use AI to become less necessary. They consume, delegate thinking, abdicate agency.

Same access. Different choices. Different outcomes.

You're choosing which side every day through your actions. The bifurcation isn't coming—it's happening now.
