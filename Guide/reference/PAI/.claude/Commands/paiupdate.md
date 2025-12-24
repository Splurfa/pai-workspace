# PAI Update - Intelligent Sideloading System

You are helping the user safely update their PAI installation while preserving their customizations.

## Overview

The user has customized their PAI system (renamed their DA, added skills, modified hooks, changed settings). They want to pull updates from the upstream PAI repository without losing their work.

## Your Task

Execute this workflow step by step:

### Phase 1: Fetch Upstream PAI

1. **Check for staging directory**: Look for `.claude/pai_updates/`

2. **Fetch latest PAI**: The user's project IS a clone of PAI. Use git to get upstream:

```bash
# Ensure we have the upstream remote
git remote get-url upstream 2>/dev/null || git remote add upstream https://github.com/danielmiessler/PAI.git

# Fetch latest from upstream (doesn't modify working directory)
git fetch upstream main

# Create staging directory
rm -rf .claude/pai_updates
mkdir -p .claude/pai_updates

# Export upstream's .claude directory to staging (clean, no .git)
git archive upstream/main -- .claude | tar -x -C .claude/pai_updates --strip-components=1
```

This gives us `.claude/pai_updates/` containing the pure upstream `.claude/` contents without affecting the user's working directory.

3. **Record version info**:
```bash
upstream_commit=$(git rev-parse upstream/main)
upstream_date=$(git log -1 --format=%ci upstream/main)
echo "Upstream: $upstream_commit ($upstream_date)"
```

4. **Check user's current sync state**: Look for `.claude/.pai-sync-history` to see when they last synced

### Phase 2: Analyze Differences

Compare the staging directory (`.claude/pai_updates/`) against the user's active directory (`.claude/`).

For each file category:

**Settings (`settings.json`)**:
- Identify new keys added upstream
- Identify keys the user has customized (especially `env.DA`, custom env vars)
- Plan a smart merge that adds new keys while preserving user values

**Skills (`.claude/Skills/`)**:
- New skills in upstream → Available to add
- Modified skills → Compare if user has customized
- User's custom skills → Never touch these

**Hooks (`.claude/Hooks/`)**:
- Critical: hooks often contain custom logic
- Check if user has modified vs. upstream version
- Identify breaking changes

**Agents (`.claude/agents/`)**:
- New agents available
- Modified agents (usually safe to update)

**Commands (`.claude/Commands/`)**:
- Don't overwrite user's custom commands
- Offer new commands from upstream

### Phase 3: Generate Report

Present a clear, organized report:

```
╔═══════════════════════════════════════════════════════════════════╗
║                     PAI UPDATE AVAILABLE                          ║
║                     Upstream: [commit hash]                       ║
║                     Your version: [last sync or "initial"]        ║
╠═══════════════════════════════════════════════════════════════════╣
║ SUMMARY                                                           ║
║ • X new files available                                           ║
║ • Y files updated upstream                                        ║
║ • Z potential conflicts with your customizations                  ║
╠═══════════════════════════════════════════════════════════════════╣
```

Then organize by category:

**🔴 REQUIRES ATTENTION** (conflicts with your customizations)
- List files where both upstream changed AND user modified
- Show what would be lost if blindly updated
- Recommend merge strategy

**🟢 SAFE TO AUTO-UPDATE** (you haven't modified these)
- List files that can be updated without risk
- These match your current upstream version

**🆕 NEW FEATURES** (available to add)
- New skills, agents, commands
- Brief description of what each does
- Recommendation based on user's apparent use case

**📝 YOUR CUSTOMIZATIONS** (will be preserved)
- List user's custom files that don't exist upstream
- Confirm these are safe

### Phase 4: Get User Decision

Present clear options:

```
What would you like to do?

[A] Apply all safe updates + add all new features (recommended for most users)
[S] Step through each change individually
[C] Conservative - only safe updates, skip new features
[M] Manual - show me the diffs, I'll decide everything
[N] Not now - keep staging for later review
```

### Phase 5: Execute Updates

For approved changes:

1. **Create backup**:
   ```bash
   timestamp=$(date +%Y%m%d_%H%M%S)
   mkdir -p .claude/pai_backups
   cp -r .claude/Skills .claude/pai_backups/skills_$timestamp
   cp -r .claude/Hooks .claude/pai_backups/hooks_$timestamp
   cp .claude/settings.json .claude/pai_backups/settings_$timestamp.json
   ```

2. **Apply changes**:
   - Copy approved new files
   - For settings.json: perform intelligent merge (preserve user keys, add new ones)
   - For conflicts user approved: apply the merge strategy they chose

3. **Update tracking**:
   ```bash
   echo "$(date -Iseconds) $(git rev-parse upstream/main)" >> .claude/.pai-sync-history
   ```

### Phase 6: Validate

After applying updates:
1. Check that settings.json is valid JSON
2. Verify no syntax errors in key hooks
3. Report success or any issues

### Phase 7: Cleanup Option

Ask if user wants to:
- Keep `.claude/pai_updates/` for reference
- Remove it to save space

---

## Important Notes

- **Never overwrite without asking** when user has customized a file
- **Always backup** before modifying existing files
- **Preserve user identity**: Their DA name, custom env vars, personal touches
- **Be conservative**: When in doubt, ask rather than overwrite
- **Explain clearly**: Users should understand what each change does

## Handling Edge Cases

**First time running `/paiupdate`**:
- No sync history exists
- Treat all current files as "user's version" (may be customized)
- Be extra careful, ask more questions

**User has diverged significantly**:
- Many files modified
- Recommend reviewing section by section
- Offer to show detailed diffs

**Upstream has breaking changes**:
- Warn prominently
- Explain what might break
- Offer to defer those specific changes

**Not a git repo (downloaded as ZIP)**:
- If no `.git` directory exists, use alternative approach:
  ```bash
  mkdir -p .claude/pai_updates
  cd .claude/pai_updates
  curl -L https://github.com/danielmiessler/PAI/archive/refs/heads/main.tar.gz | tar -xz --strip-components=2 PAI-main/.claude
  ```
- Inform user they should consider using git for easier future updates

**User forked PAI**:
- Their `origin` is their fork, not upstream PAI
- Check if `upstream` remote exists, add it if not
- This is the expected setup for most users

---

## Begin Now

Start by checking for the staging directory and fetching the latest PAI. Then analyze and report.

$ARGUMENTS
