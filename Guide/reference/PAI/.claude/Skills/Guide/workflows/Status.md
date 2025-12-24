# Status Workflow

Show current progress through PAI setup.

---

## Process

1. Read `../Progress.md`
2. Parse checkbox states from each phase
3. Calculate completion percentages
4. Identify current step (first unchecked item)
5. Display formatted status
6. Show any notes or blockers

---

## Output Format

```
═══════════════════════════════════════════
          PAI SETUP PROGRESS
═══════════════════════════════════════════

PHASE 1: Installation [4/6 complete]
  ✅ Back up existing ~/.claude
  ✅ Remove existing ~/.claude
  ✅ Clone PAI repository
  ✅ Create symlink
  → Run bootstrap wizard          ← CURRENT
  ○ Reload shell

PHASE 2: Configuration [0/6 complete]
  ○ Create .env from template
  ○ Configure DA name
  ○ Configure DA color
  ○ Add ElevenLabs API key
  ○ Add Google API key
  ○ Verify environment variables

PHASE 3: Voice System [0/3 complete]
  ○ Install voice server
  ○ Verify health endpoint
  ○ Test voice notification

PHASE 4: Verification [0/6 complete]
  ○ Launch Claude Code
  ○ Verify SessionStart hook
  ○ Test CORE skill
  ○ Test skill routing
  ○ Test agent access
  ○ Verify history directories

PHASE 5: First Use [0/4 complete]
  ○ Read CONSTITUTION thoroughly
  ○ Try a Fabric pattern
  ○ Try agent delegation
  ○ Create a simple skill (optional)

═══════════════════════════════════════════
OVERALL: 4/25 steps (16%)

CONFIGURATION:
  • DA Name: [not set]
  • DA Color: [not set]
  • Shell: [not detected]

NOTES: [any from Progress.md Notes section]

NEXT STEP: Run bootstrap wizard
  └─ Command: ~/.claude/Tools/setup/bootstrap.sh
═══════════════════════════════════════════
```

---

## Legend

| Symbol | Meaning |
|--------|---------|
| ✅ | Completed |
| → | Current step |
| ○ | Not started |
| ⚠️ | Blocked/Issue |

---

## Reading Progress.md

Progress.md uses standard markdown checkboxes:
- `- [x]` = completed
- `- [ ]` = not completed

Count checkboxes in each phase section to calculate completion.

---

## Configuration Detection

Read the Configuration Decisions table in Progress.md:

```markdown
## Configuration Decisions

| Setting | Value |
|---------|-------|
| **DA Name** | YourName |
| **DA Color** | purple |
| **Shell** | zsh |
```

Extract values from the Value column.

---

## Notes Detection

Read the Notes section in Progress.md:

```markdown
## Notes

_Record any blockers, issues, or observations here._
```

Display any content that isn't the default placeholder text.

---

## Next Step Detection

Find the first unchecked item `- [ ]` in Progress.md.
Look up the corresponding command in `Setup.md`.

If all items checked, display:
```
STATUS: Setup Complete!

Your PAI workspace is fully configured.
Read the CONSTITUTION and start building.
```
