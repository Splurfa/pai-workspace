# PAI Setup Progress

**Phase:** 1 — Installation
**Updated:** 2024-12-24

---

## The 13 Principles (North Star)

These guide every decision. Refer to `Principles.md` for full details.

1. Clear Thinking + Prompting is King
2. Scaffolding > Model
3. As Deterministic as Possible
4. Code Before Prompts
5. Spec / Test / Evals First
6. UNIX Philosophy (Modular Tooling)
7. ENG / SRE Principles ++
8. CLI as Interface
9. Goal → Code → CLI → Prompts → Agents
10. Meta / Self-Update System
11. Custom Skill Management
12. Custom History System
13. Custom Agent Personalities / Voices

---

## Phase 1: Installation

- [x] Back up existing ~/.claude (if any) — skipped, fresh start
- [x] Remove existing ~/.claude directory
- [x] Clone PAI repository to ~/PAI
- [x] Create symlink: ~/.claude → ~/PAI/.claude
- [x] Run bootstrap wizard: `~/.claude/Tools/setup/bootstrap.sh`
- [ ] Reload shell: `source ~/.zshrc`

---

## Phase 2: Configuration

- [ ] Create .env from template: `cp ~/.claude/.env.example ~/.claude/.env`
- [ ] Configure DA name in settings.json
- [ ] Configure DA color in settings.json
- [ ] Add ElevenLabs API key to .env
- [ ] Add Google API key to .env (optional)
- [ ] Verify environment variables: `echo $DA`

---

## Phase 3: Voice System

- [ ] Install voice server: `cd ~/.claude/voice-server && ./install.sh`
- [ ] Verify health endpoint: `curl http://localhost:8888/health`
- [ ] Test voice notification

---

## Phase 4: Verification

- [ ] Launch Claude Code: `claude`
- [ ] Verify SessionStart hook fires
- [ ] Test CORE skill loads: "Read the CONSTITUTION"
- [ ] Test skill routing: "What skills are available?"
- [ ] Test agent access: "What agents do I have?"
- [ ] Verify history directories exist: `ls ~/.claude/History/`

---

## Phase 5: First Use

- [ ] Read CONSTITUTION.md thoroughly
- [ ] Try a Fabric pattern
- [ ] Try agent delegation
- [ ] Create a simple skill (optional)

---

## Configuration Decisions

| Setting | Value |
|---------|-------|
| **DA Name** | Synergy |
| **DA Color** | blue |
| **Shell** | zsh |

---

## Notes

_Record any blockers, issues, or observations here._

---

## What's Next

After completing setup, PAI becomes your operating environment. This Guide skill can be handed to PAI for potential refactoring into an ongoing learning companion.

The principles above aren't checkboxes—they're lenses for evaluating every decision you make with AI.
