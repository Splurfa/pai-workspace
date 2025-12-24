# Verify Workflow

Validate that setup steps completed correctly. Diagnose and fix issues.

---

## Process

1. Identify what user wants to verify
2. Run verification command(s)
3. Compare output to expected result
4. If wrong: diagnose and provide fix
5. If correct: update Progress.md checkbox

---

## Quick Verification Commands

### Installation

**Symlink correct?**
```bash
ls -la ~/.claude
```
Expected: `~/.claude -> ~/PAI/.claude`

**PAI cloned completely?**
```bash
ls ~/PAI/.claude/Skills/CORE/CONSTITUTION.md
```
Expected: File exists

**Bootstrap ran?**
```bash
cat ~/.claude/settings.json | grep "DA"
```
Expected: Shows DA name value

---

### Configuration

**Environment variables loaded?**
```bash
echo "PAI_DIR=$PAI_DIR DA=$DA"
```
Expected: Both show values (not blank)

**.env exists with keys?**
```bash
grep "API_KEY" ~/.claude/.env | wc -l
```
Expected: At least 1 (ElevenLabs minimum)

**Settings.json valid JSON?**
```bash
cat ~/.claude/settings.json | python3 -m json.tool > /dev/null && echo "Valid JSON"
```
Expected: "Valid JSON"

---

### Voice System

**Server running?**
```bash
curl -s http://localhost:8888/health | grep status
```
Expected: `"status": "healthy"`

**Port 8888 in use?**
```bash
lsof -i :8888 | grep LISTEN
```
Expected: Shows bun process

**ElevenLabs API key valid?**
```bash
curl -s http://localhost:8888/health | grep elevenlabs
```
Expected: Shows connected status

---

### History System

**Directories exist?**
```bash
ls ~/.claude/History/
```
Expected: Sessions, Learnings, Raw-Outputs directories

**Events capturing?**
```bash
ls ~/.claude/History/Raw-Outputs/$(date +%Y-%m)/ 2>/dev/null | head -3
```
Expected: .jsonl files (after using Claude Code)

---

### Hooks

**Hooks registered?**
```bash
grep -A 20 '"hooks"' ~/.claude/settings.json | head -25
```
Expected: Shows hook configurations

**SessionStart hook works?**
Start Claude Code and check for welcome message or voice notification.

---

## Common Issues & Fixes

### "Symlink is broken"

**Symptom:** `ls ~/.claude` shows red/broken link

**Cause:** Target directory doesn't exist

**Fix:**
```bash
rm ~/.claude
ls ~/PAI/.claude  # Verify target exists
ln -s ~/PAI/.claude ~/.claude
```

---

### "Voice server won't start"

**Symptom:** `curl localhost:8888/health` fails

**Check 1: Port already in use?**
```bash
lsof -i :8888
```
If something else is using it:
```bash
lsof -ti:8888 | xargs kill -9
```

**Check 2: Bun installed?**
```bash
which bun
bun --version
```
If missing:
```bash
curl -fsSL https://bun.sh/install | bash
source ~/.zshrc
```

**Check 3: Dependencies installed?**
```bash
cd ~/.claude/voice-server
bun install
bun run start
```

---

### "Environment variables not loading"

**Symptom:** `echo $DA` returns blank

**Check 1: Shell config updated?**
```bash
grep "PAI" ~/.zshrc
```
If missing, bootstrap didn't complete. Re-run:
```bash
~/.claude/Tools/setup/bootstrap.sh
```

**Check 2: Shell reloaded?**
```bash
source ~/.zshrc
```

**Check 3: Using wrong shell?**
```bash
echo $SHELL
```
If bash, check `~/.bashrc` instead.

---

### "History not capturing"

**Symptom:** No .jsonl files in Raw-Outputs

**Check 1: Hooks registered?**
```bash
grep "PostToolUse" ~/.claude/settings.json
```

**Check 2: History directory exists?**
```bash
mkdir -p ~/.claude/History/{Sessions,Learnings,Raw-Outputs}
```

**Check 3: Write permissions?**
```bash
touch ~/.claude/History/test && rm ~/.claude/History/test && echo "OK"
```

---

### "Skills not loading"

**Symptom:** Claude doesn't recognize skill commands

**Check 1: SKILL.md exists?**
```bash
ls ~/.claude/Skills/*/SKILL.md
```

**Check 2: Symlink correct?**
```bash
ls -la ~/.claude
```
Should point to `~/PAI/.claude`

**Check 3: Claude Code restarted?**
Skills load at session start. Restart Claude Code after changes.

---

### "Agents not available"

**Symptom:** "I don't have access to that agent"

**Check 1: Agent files exist?**
```bash
ls ~/.claude/Agents/*.md
```

**Check 2: Agent format correct?**
```bash
head -10 ~/.claude/Agents/researcher.md
```
Should have YAML frontmatter with `name:` and `description:`

---

### "Bootstrap fails"

**Symptom:** Error during `bootstrap.sh`

**Check 1: Script executable?**
```bash
chmod +x ~/.claude/Tools/setup/bootstrap.sh
```

**Check 2: Bun available?**
```bash
which bun || curl -fsSL https://bun.sh/install | bash
```

**Check 3: Read error output**
Run bootstrap with debug:
```bash
bash -x ~/.claude/Tools/setup/bootstrap.sh 2>&1 | tee bootstrap.log
```

---

### "settings.json invalid"

**Symptom:** Claude Code won't start or has errors

**Check syntax:**
```bash
cat ~/.claude/settings.json | python3 -m json.tool
```

**Common issues:**
- Trailing comma after last item in object
- Missing comma between items
- Unmatched braces

**Fix:** Edit file, correct JSON syntax.

**Nuclear option:** Re-run bootstrap to regenerate:
```bash
~/.claude/Tools/setup/bootstrap.sh
```

---

## Verification Checklist

Run all checks at once:

```bash
echo "=== PAI Verification ===" && \
echo "Symlink:" && ls -la ~/.claude 2>/dev/null | grep "\->" && \
echo "Constitution:" && ls ~/PAI/.claude/Skills/CORE/CONSTITUTION.md 2>/dev/null && echo "OK" && \
echo "DA:" && echo $DA && \
echo "Voice:" && curl -s http://localhost:8888/health | grep status && \
echo "History:" && ls ~/.claude/History/ 2>/dev/null && \
echo "=== Done ==="
```

All lines should show expected values. Any blank or error = that step needs attention.
