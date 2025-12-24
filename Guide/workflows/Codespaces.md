# Codespaces Setup Workflow

Streamlined PAI installation for GitHub Codespaces. All features work except voice notifications (no audio device in cloud).

---

## Quick Start (One Command)

```bash
# Clone, symlink, bootstrap, configure — all in one
git clone https://github.com/danielmiessler/PAI.git ~/PAI && \
ln -s ~/PAI/.claude ~/.claude && \
curl -fsSL https://bun.sh/install | bash && \
source ~/.bashrc && \
~/.claude/Tools/setup/bootstrap.sh --skip-voice
```

After bootstrap completes:
```bash
source ~/.bashrc
claude
```

---

## Manual Setup (5 Steps)

### Step 1: Install Bun

PAI requires Bun runtime for hooks and automation.

```bash
curl -fsSL https://bun.sh/install | bash
source ~/.bashrc
bun --version
```

**Success:** Version number displayed (e.g., `1.x.x`)

---

### Step 2: Clone PAI

```bash
git clone https://github.com/danielmiessler/PAI.git ~/PAI
```

**Success:** `~/PAI/.claude/` directory exists

---

### Step 3: Create Symlink

```bash
ln -s ~/PAI/.claude ~/.claude
ls -la ~/.claude
```

**Success:** Shows `~/.claude -> ~/PAI/.claude`

---

### Step 4: Run Bootstrap

```bash
~/.claude/Tools/setup/bootstrap.sh
```

The wizard will:
- Detect Linux/Codespaces environment
- **Automatically skip voice server** (no audio device)
- Configure your DA name and color
- Set up environment variables

**Alternatively, run non-interactive:**
```bash
cd ~/.claude/Tools/setup && bun run setup.ts \
  --assistant-name "Synergy" \
  --assistant-color "blue" \
  --skip-voice \
  --force
```

---

### Step 5: Configure API Keys

```bash
cp ~/.claude/.env.example ~/.claude/.env
nano ~/.claude/.env
```

Add your keys:
```bash
# Required for research features
GOOGLE_API_KEY=your_key_here

# Optional
PERPLEXITY_API_KEY=your_key_here
OPENAI_API_KEY=your_key_here
```

**Note:** `ELEVENLABS_API_KEY` not needed — voice is disabled on Codespaces.

---

## Activate & Verify

```bash
source ~/.bashrc
echo $DA           # Should show your assistant name
echo $PAI_DIR      # Should show ~/.claude or path

claude
```

Inside Claude Code:
```
Read the CONSTITUTION
What skills are available?
What agents do I have?
```

---

## Feature Parity: Codespaces vs Local

| Feature | Codespaces | Local macOS |
|---------|------------|-------------|
| Skills (248 Fabric patterns) | ✅ | ✅ |
| Agents (8 personalities) | ✅ | ✅ |
| Hooks (automation) | ✅ | ✅ |
| History (UOCS capture) | ✅ | ✅ |
| Research agents | ✅ | ✅ |
| Web scraping (4-tier) | ✅ | ✅ |
| Observability dashboard | ✅ | ✅ |
| Voice notifications | ❌ | ✅ |
| Menu bar indicator | ❌ | ✅ |

**You lose voice. You keep everything else.**

---

## Codespaces-Specific Notes

### Storage is Ephemeral
Codespaces containers reset. To preserve customizations:
- Commit changes to your fork
- Use GitHub Dotfiles for shell config
- Store API keys in Codespaces Secrets (Settings → Secrets)

### Port Forwarding (If Needed)
If you run the voice server anyway for testing:
```bash
cd ~/.claude/voice-server && bun run server.ts
```
Codespaces will prompt to forward port 8888. Health check works; audio won't play.

### Recommended Machine Size
- **4-core (default):** Works fine for most tasks
- **8-core:** Better for parallel agents and large codebases

---

## Troubleshooting

### Bun not found after install
```bash
export PATH="$HOME/.bun/bin:$PATH"
echo 'export PATH="$HOME/.bun/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

### PAI_DIR not set
```bash
source ~/.bashrc
# If still not set, add manually:
echo 'export PAI_DIR="$HOME/.claude"' >> ~/.bashrc
source ~/.bashrc
```

### Bootstrap fails
Run setup directly:
```bash
cd ~/.claude/Tools/setup
bun run setup.ts --skip-voice --force
```

### Claude Code not loading PAI context
Verify settings.json has hooks configured:
```bash
grep "SessionStart" ~/.claude/settings.json
```

---

## Why Codespaces?

For constrained hardware (8GB RAM M1 Macs, limited SSD):
- **Dedicated resources** — 4-8GB RAM just for Claude Code
- **No thermal throttling** — cloud compute doesn't overheat
- **No battery drain** — heavy work happens remotely
- **Fresh environment** — no accumulated memory leaks

**Cost:** ~$7-20/month depending on usage. Worth it for constrained hardware.

---

## Next Steps

After setup:
1. **Read CONSTITUTION** — understand how your DA behaves
2. **Try Fabric patterns** — "Summarize this: [text]"
3. **Try agent delegation** — "Use the research agent to find..."
4. **Explore skills** — `ls ~/.claude/Skills/`

You're running PAI in the cloud. All features except voice work identically.
