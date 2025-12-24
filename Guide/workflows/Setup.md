# Setup Workflow

Step-by-step PAI installation. No shortcuts. Fully-featured workspace.

---

## Before Each Step

1. Read `../Progress.md` to know current state
2. Identify next uncompleted step
3. Provide context: why this step, what it enables
4. Give exact command(s) to run
5. Explain what success looks like
6. Wait for user confirmation
7. Update Progress.md checkbox when confirmed

---

## Phase 1: Installation (~10 min)

### Step 1.1: Back Up Existing ~/.claude

**Why:** If you have existing Claude customizations, preserve them.

**Check first:**
```bash
ls -la ~/.claude 2>/dev/null
```

**If it exists:**
```bash
cp -r ~/.claude ~/.claude-backup-$(date +%Y%m%d)
```

**Principle:** ENG/SRE (7) — Don't destroy data without backups.

---

### Step 1.2: Remove Existing ~/.claude

**Why:** PAI replaces your entire ~/.claude directory. Clean slate required.

**Command:**
```bash
rm -rf ~/.claude
```

**Success:** `ls ~/.claude` returns "No such file or directory"

**Principle:** As Deterministic as Possible (3) — Start from known state.

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
