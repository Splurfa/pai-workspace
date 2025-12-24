# Dependency Map

<!-- MODE: EXPLANATION ONLY - Describe relationships factually, no recommendations -->

Show dependencies, order-of-operations, and cascading effects.

---

## Process

1. Identify the component/step in question
2. Map what it depends on (prerequisites)
3. Map what depends on it (enables)
4. Show 2nd/3rd order effects
5. Explain why order matters

---

## Dependency Maps

### Installation Phase
```
Clone PAI
    └─► Symlink
            └─► Bootstrap
                    └─► Everything else
```

### Voice System
```
.env (ELEVENLABS keys)
    └─► Voice server install
            └─► Health check
                    └─► Hooks can notify
                            ├─► stop-hook.ts
                            ├─► subagent-stop-hook.ts
                            └─► Any voice notification
```

### Hook System
```
settings.json (hooks config)
    └─► Hook scripts exist
            └─► Voice server running
                    └─► History directories exist
                            └─► Hooks can:
                                    ├─► Announce completions
                                    ├─► Capture sessions
                                    ├─► Log all events
                                    └─► Update tabs
```

### History System (UOCS)
```
History/ directories
    └─► Hooks capture events
            └─► Raw-Outputs (JSONL)
            └─► Sessions (summaries)
            └─► Learnings (patterns)
                    └─► Searchable history
                            └─► /search-history command
                            └─► Past work reference
```

### Skill System
```
Skills/CORE/SKILL.md
    └─► SessionStart hook loads it
            └─► USE WHEN triggers parsed
                    └─► Skills activate on intent
                            └─► Workflows execute
                                    └─► Tools run
```

### Agent System
```
Agents/*.md definitions
    └─► Task tool available
            └─► Model selection (opus/sonnet/haiku)
                    └─► Delegation patterns work
                            ├─► Sequential
                            ├─► Parallel
                            └─► Nested
```

---

## Order Effects

These describe what happens when components are absent. This is factual description, not recommendation.

### Without voice server running:
- Hooks POST to localhost:8888
- No listener receives the request
- Requests fail silently (no error visible)
- Task completions appear only in terminal output

### Without symlink configured:
- Claude Code looks for ~/.claude
- Path doesn't exist or points elsewhere
- Skills don't load (no SKILL.md found)
- Hooks don't fire (no hooks directory)
- PAI infrastructure is invisible to Claude

### Without hooks enabled:
- No automatic event capture
- Session summaries don't generate
- Voice feedback doesn't trigger
- History directories remain empty

### Without .env API keys:
- Voice server starts (port 8888 active)
- Synthesis requests fail (no ElevenLabs auth)
- Research agents can't authenticate to external APIs
- Features degrade without error messages

---

## 2nd/3rd Order Effects

How dependencies cascade into higher-order outcomes.

### Voice Server Chain
1st order: Task completions produce audio announcements
2nd order: Attention can shift away from terminal during long tasks
3rd order: Delegation becomes viable for multi-step workflows

### History System Chain
1st order: Sessions, learnings, and outputs are captured
2nd order: Past work becomes searchable via /search-history
3rd order: Patterns across sessions become visible for analysis

### Skill System Chain
1st order: Skills activate based on intent matching
2nd order: Custom skills can be created following the same pattern
3rd order: PAI infrastructure extends to new domains
