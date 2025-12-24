# Setup Workflow

Step-by-step PAI installation. No shortcuts. Fully-featured workspace.

---

## Environment Detection

**Running in GitHub Codespaces or cloud container?**

Check: `echo $CODESPACES` — if it returns `true`, use the [Codespaces Setup](Codespaces.md) workflow instead.

| Environment | Workflow | Voice Support |
|-------------|----------|---------------|
| **Codespaces / Cloud** | [Codespaces.md](Codespaces.md) | ❌ No audio device |
| **Local macOS** | This file (Setup.md) | ✅ Full voice |
| **Local Linux** | This file (Setup.md) | ❌ Voice auto-skipped |

---

## Before Each Step

### For the Guide (AI)
1. Read `../Progress.md` to know current state
2. Identify next uncompleted step
3. **Explain the CONCEPT before showing commands**
4. Verify user understands before executing
5. Give exact command(s) only after understanding confirmed
6. Explain what success looks like
7. Wait for user to confirm BOTH understanding AND completion
8. Update Progress.md checkbox when confirmed

### For the User
1. Read the explanation section first
2. Connect the step to the relevant principle
3. Ask questions if anything is unclear
4. Execute only after understanding
5. Verify output matches expected result

---

## Phase 1: Installation (~10 min)

### What This Phase Accomplishes

**Conceptual Goal:** Transform your machine from "has Claude Code" to "has PAI infrastructure pointing at Claude Code."

**Key Insight:** PAI isn't a replacement for Claude Code—it's a scaffolding layer. The symlink pattern (Step 1.4) is critical: `~/.claude` is where Claude Code looks, but your files live in `~/PAI/.claude`. This indirection allows PAI to remain a git repository you can update.

**Principles in Play:**
- **Scaffolding > Model (2):** Installing infrastructure, not prompts
- **As Deterministic as Possible (3):** Starting from known, clean state
- **CLI as Interface (8):** Using standard UNIX patterns (symlinks)

**Before Starting Phase 1:**
- [ ] I understand that PAI wraps Claude Code, not replaces it
- [ ] I know what a symlink is (pointer to another location)
- [ ] I understand why we remove existing `~/.claude` before creating the symlink

### Step 1.1: Back Up Existing ~/.claude

---
**MODE: EXPLAIN**
---

**Concept:** Claude Code stores its configuration in `~/.claude`. This includes settings, custom skills you may have created, project data, and session history. Before PAI takes over this directory, any existing content should be preserved.

**Principle Connection (7: ENG/SRE):** Production systems never destroy data without backups. Even if you think there's nothing valuable, the backup costs nothing and prevents regret.

**What Could Go Wrong:**
- Without backup: Any custom settings or skills you created are permanently lost
- With backup: You can always restore if something doesn't work

---
**MODE: VERIFY UNDERSTANDING**
---

Before proceeding:
- [ ] I understand `~/.claude` may contain existing Claude Code configuration
- [ ] I know the backup will be named `~/.claude-backup-YYYYMMDD`
- [ ] I can restore from backup if needed

---
**MODE: EXECUTE**
---

**Check if directory exists:**
```bash
ls -la ~/.claude 2>/dev/null
```

**If it exists, create backup:**
```bash
cp -r ~/.claude ~/.claude-backup-$(date +%Y%m%d)
```

**If it doesn't exist:** Skip to Step 1.2.

**Success:** Backup directory exists at `~/.claude-backup-YYYYMMDD`, or original `~/.claude` didn't exist.

---

### Step 1.2: Remove Existing ~/.claude

---
**MODE: EXPLAIN**
---

**Concept:** PAI needs exclusive ownership of `~/.claude`. The symlink we'll create in Step 1.4 must point to PAI's infrastructure. If a directory already exists at `~/.claude`, the symlink creation will fail or behave unexpectedly.

**Principle Connection (3: As Deterministic as Possible):** Starting from a known, clean state eliminates variables. An empty path is predictable; an existing directory with unknown contents is not.

**What This Enables:**
- Clean symlink creation (Step 1.4)
- No conflicts between old config and PAI
- Predictable Claude Code behavior

**What Could Go Wrong:**
- If skipped: Symlink fails or points incorrectly
- If backup skipped: Data loss (but Step 1.1 prevents this)

---
**MODE: VERIFY UNDERSTANDING**
---

Before proceeding:
- [ ] I completed Step 1.1 (backup exists or wasn't needed)
- [ ] I understand this removes the directory, making way for the symlink
- [ ] I know PAI will provide new configuration via `~/PAI/.claude`

---
**MODE: EXECUTE**
---

**Command:**
```bash
rm -rf ~/.claude
```

**Verify removal:**
```bash
ls ~/.claude
```

**Success:** Returns "No such file or directory"

**What You Just Did:** Cleared the path for PAI's symlink. Claude Code will now look for `~/.claude` and find nothing—until Step 1.4 creates the symlink.

---

### Step 1.3: Clone PAI

**Why:** Get the full PAI repository to your machine.

**Command:**
```bash
git clone https://github.com/danielmiessler/PAI.git ~/PAI
```

**Success:** `~/PAI` directory exists with `.claude` inside.

**Verify:**
```bash
ls ~/PAI/.claude/Skills/CORE/CONSTITUTION.md
```

**Principle:** Scaffolding > Model (2) — You're installing infrastructure, not just prompts.

---

### Step 1.3: Create Symlink

**Why:** Claude Code looks for `~/.claude`. Symlink makes it find PAI's `.claude`.

**Command:**
```bash
ln -s ~/PAI/.claude ~/.claude
```

**Success:**
```bash
ls -la ~/.claude
# Shows: ~/.claude -> ~/PAI/.claude
```

**Principle:** CLI as Interface (8) — Standard UNIX approach.

---

### Step 1.4: Run Bootstrap

**Why:** Interactive wizard configures identity, checks dependencies, sets up environment.

**Command:**
```bash
~/.claude/Tools/setup/bootstrap.sh
```

**During wizard you'll configure:**
- Shell check (zsh/bash recommended)
- Bun installation (if missing)
- Claude Code check
- Identity (name, email, DA name, color)

**Success:** Wizard completes without errors.

**Principle:** Meta/Self-Update (10) — The system configures itself.

---

### Step 1.5: Reload Shell

**Why:** Load PAI environment variables into current session.

**Command:**
```bash
source ~/.zshrc   # or ~/.bashrc
```

**Verify:**
```bash
echo $PAI_DIR    # Should show ~/.claude or ~/PAI/.claude
echo $DA         # Should show your DA name
```

**Success:** Both variables return values.

---

## Phase 2: Configuration (~5 min)

### Step 2.1: Create .env

**Why:** API keys live in .env (never committed to git).

**Command:**
```bash
cp ~/.claude/.env.example ~/.claude/.env
```

**Success:** `~/.claude/.env` exists.

**Principle:** ENG/SRE (7) — Secrets separated from code.

---

### Step 2.2: Configure Identity

**Why:** Your DA name flows throughout the system.

**Edit:** `~/.claude/settings.json` → find the `env` section

```json
{
  "env": {
    "DA": "YourAssistantName",
    "DA_COLOR": "purple"
  }
}
```

**Decision needed:** What do you want to name your AI assistant?

**Principle:** Custom Agent Personalities (13) — Your AI has an identity.

---

### Step 2.3: Add API Keys

**Why:** Enable voice and research features.

**Edit:** `~/.claude/.env`

```bash
# Required for voice
ELEVENLABS_API_KEY=your_key
ELEVENLABS_VOICE_ID=s3TPKV1kjDlVtZbl4Ksh

# Optional for research
GOOGLE_API_KEY=your_key
```

**Get keys:**
- ElevenLabs: https://elevenlabs.io (free tier available)
- Google: https://console.cloud.google.com/apis

**Success:** Keys are in .env file (verify with `grep "KEY" ~/.claude/.env`)

---

## Phase 3: Voice System (~5 min)

### Step 3.1: Install Voice Server

**Why:** Hooks trigger voice notifications after tasks complete.

**Command:**
```bash
cd ~/.claude/voice-server && ./install.sh
```

**Success:** Installer completes, service starts.

**Principle:** Custom Agent Personalities (13) — Your AI speaks.

---

### Step 3.2: Verify Health

**Command:**
```bash
curl http://localhost:8888/health
```

**Success:** JSON response with `"status": "healthy"`

**If it fails:** Check Step 3.1 completed, or see Verify workflow troubleshooting.

---

### Step 3.3: Test Notification

**Command:**
```bash
curl -X POST http://localhost:8888/notify \
  -H "Content-Type: application/json" \
  -d '{"message": "PAI voice system working"}'
```

**Success:** You hear the message spoken aloud.

---

## Phase 4: Verification (~5 min)

### Step 4.1: Launch Claude Code

**Command:**
```bash
claude
```

**Success:** Claude Code starts, PAI context loads (SessionStart hook fires).

---

### Step 4.2: Test CORE Skill

**In Claude Code, say:**
```
Read the CONSTITUTION
```

**Success:** Claude reads and summarizes CONSTITUTION.md.

**Principle:** Custom Skill Management (11) — Skills route correctly.

---

### Step 4.3: Test Skill Routing

**Say:**
```
What skills are available?
```

**Success:** Lists skills from ~/.claude/Skills/

---

### Step 4.4: Test Agent Access

**Say:**
```
What agents do I have access to?
```

**Success:** Lists agents with their purposes.

---

### Step 4.5: Verify History Capture

**Check:**
```bash
ls ~/.claude/History/
```

**Success:** Directories exist (Sessions, Learnings, Raw-Outputs, etc.)

**Principle:** Custom History System (12) — Context persists.

---

## Phase 5: First Use

### Step 5.1: Read CONSTITUTION

In Claude Code:
```
Read the CONSTITUTION thoroughly and explain the key points
```

This is your foundation. Understand it before building.

---

### Step 5.2: Try a Fabric Pattern

```bash
echo "This is a test article about AI." | fabric --pattern summarize
```

**Principle:** UNIX Philosophy (6) — Composable tools.

---

### Step 5.3: Try Agent Delegation

In Claude Code:
```
Use the research agent to find information about [topic]
```

**Principle:** Goal → Code → CLI → Prompts → Agents (9) — Full stack working.

---

## After Each Step

1. Update `../Progress.md` checkbox
2. Note any decisions made in Configuration section
3. Log any issues in Notes section
4. Proceed to next step
