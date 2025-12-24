# Context Workflow

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

## Why Order Matters

### If you skip voice server:
- Hooks try to POST to localhost:8888
- Requests fail silently
- No completion announcements
- You don't know when tasks finish

### If you skip symlink:
- Claude Code can't find ~/.claude
- No skills load
- No hooks fire
- PAI doesn't exist to Claude

### If hooks aren't configured:
- No automatic capture
- No session summaries
- No voice feedback
- History stays empty

### If .env missing keys:
- Voice server starts but can't synthesize
- Research agents can't call APIs
- Features silently degrade

---

## 2nd/3rd Order Effects

### Voice Server → Productivity
1st: You hear task completions
2nd: You can work on other things while waiting
3rd: Trust in system grows, you delegate more

### History System → Learning
1st: Sessions are captured
2nd: You can search past work
3rd: Patterns emerge, you improve workflows

### Skill System → Scaling
1st: Skills activate on intent
2nd: You create custom skills
3rd: Your PAI becomes uniquely yours
