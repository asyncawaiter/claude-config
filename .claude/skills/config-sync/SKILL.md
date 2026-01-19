---
name: config-sync
description: Sync Claude Code configuration between local machine and remote GitHub repo. Compares skills, commands, hooks, and statusline between local ~/.claude and remote, allowing selective sync in both directions.
context: fork
---

# Config Sync

Synchronize Claude Code configuration between your local machine and the remote GitHub repository.

## Usage

```
/config-sync
```

## Configuration

The remote repository URL is: `https://github.com/asyncawaiter/claude-config.git`

## What Gets Synced

The following paths are compared and can be synced:

| Type | Local Path | Remote Path |
|------|------------|-------------|
| Skills | `~/.claude/skills/` | `.claude/skills/` (if present) |
| Commands | `~/.claude/commands/` | `.claude/commands/` |
| Hooks | `~/.claude/hooks/` | `.claude/hooks/` (if present) |
| Statusline | `~/.claude/statusline-command.sh` | `.claude/statusline-command.sh` |

**Excluded from sync:**
- `settings.json` (contains machine-specific plugin configs)
- `settings.local.json` (local overrides)
- `history.jsonl`, `stats-cache.json` (ephemeral data)
- `projects/`, `todos/`, `session-env/` (session data)

## Workflow

### Step 1: Clone Remote Repository

Clone the remote config repository to a temporary location:

```bash
TEMP_DIR=$(mktemp -d)
git clone https://github.com/asyncawaiter/claude-config.git "$TEMP_DIR" 2>&1
```

Store the temp directory path for later cleanup.

### Step 2: Analyze Differences

Compare the remote `.claude/` folder with local `~/.claude/` for the syncable paths.

#### 2a: Find items in REMOTE but not LOCAL (available to install)

For each syncable category, check what exists in remote but not locally:

```bash
# Check commands
REMOTE_COMMANDS="$TEMP_DIR/.claude/commands"
LOCAL_COMMANDS="$HOME/.claude/commands"

# List remote commands
if [ -d "$REMOTE_COMMANDS" ]; then
    ls "$REMOTE_COMMANDS" 2>/dev/null
fi

# Compare with local
if [ -d "$LOCAL_COMMANDS" ]; then
    ls "$LOCAL_COMMANDS" 2>/dev/null
fi
```

Do the same for:
- `skills/` directories (compare subdirectory names)
- `hooks/` scripts
- `statusline-command.sh` (check if exists and compare content with `diff`)

#### 2b: Find items in LOCAL but not REMOTE (can be pushed)

Same comparison but reversed - items that exist locally but not in remote.

### Step 3: Present Remote-Only Items to User

If there are items in remote that don't exist locally, present them to the user.

Format the output clearly:

```
## Available from Remote (not installed locally)

### Commands
- shareable-doc.md - Generate shareable documentation

### Skills
- (none found)

### Hooks
- (none found)

### Other
- statusline-command.sh - Custom status line script
```

Then use **AskUserQuestion** to let the user select which items to install:

```
Which items would you like to install from the remote repository?
```

Options should include each available item, with multiSelect: true.

### Step 4: Install Selected Items

For each selected item, copy from the temp directory to the appropriate local location:

```bash
# Example: Install a command
cp "$TEMP_DIR/.claude/commands/shareable-doc.md" "$HOME/.claude/commands/"

# Example: Install statusline
cp "$TEMP_DIR/.claude/statusline-command.sh" "$HOME/.claude/"
chmod +x "$HOME/.claude/statusline-command.sh"
```

For skills (which are directories), use recursive copy:
```bash
cp -r "$TEMP_DIR/.claude/skills/some-skill" "$HOME/.claude/skills/"
```

Report what was installed.

### Step 5: Present Local-Only Items to User

If there are items locally that don't exist in remote, present them:

```
## Local Items (not in remote repository)

### Commands
- my-custom-command.md

### Skills
- my-local-skill/

### Hooks
- my-hook.sh
```

Then use **AskUserQuestion**:

```
Would you like to push any local items to the remote repository?
```

Options:
- "Yes, let me select which ones"
- "No, skip pushing"

### Step 6: Push Selected Items to Remote

If user wants to push:

1. Ask which items to push (multiSelect)
2. Copy selected items to the temp repo directory
3. Commit and push:

```bash
cd "$TEMP_DIR"
git add .
git commit -m "Add local configurations from $(hostname)"
git push origin main
```

**Important:** This requires the user to have push access to the repository. If push fails due to authentication, inform the user they need to:
- Configure git credentials, OR
- Fork the repo and update the remote URL

### Step 7: Update README.md (MANDATORY)

**This step is ALWAYS performed after any sync operation, regardless of whether items were installed or pushed.**

Generate an updated `README.md` that documents ALL features currently in the repository. The README must be self-contained and provide a complete overview.

#### 7a: Scan Repository Contents

Scan the temp repo directory (after any sync changes) to inventory all features:

```bash
# List all skills
ls "$TEMP_DIR/.claude/skills/" 2>/dev/null

# List all commands
ls "$TEMP_DIR/.claude/commands/" 2>/dev/null

# List all hooks
ls "$TEMP_DIR/.claude/hooks/" 2>/dev/null

# Check for statusline
ls "$TEMP_DIR/.claude/statusline-command.sh" 2>/dev/null
```

#### 7b: Extract Descriptions

For each skill, read its `SKILL.md` frontmatter to extract name and description:

```bash
# Example: Extract from SKILL.md
head -20 "$TEMP_DIR/.claude/skills/some-skill/SKILL.md"
```

Look for the YAML frontmatter:
```yaml
---
name: skill-name
description: The skill description here
---
```

For commands (`.md` files), read the first few lines to get the title and purpose.

For hooks (`.sh` files), look for a comment header describing purpose.

#### 7c: Generate README.md

Write a new `README.md` to the temp repo with this structure:

```markdown
# Claude Config

Personal Claude Code configuration repository. Clone and use `/config-sync` to sync with your local machine.

## Quick Start

```bash
# Clone this repo
git clone https://github.com/asyncawaiter/claude-config.git

# Copy the config-sync skill to enable syncing
cp -r claude-config/.claude/skills/config-sync ~/.claude/skills/

# Run the sync command in Claude Code
/config-sync
```

## Features

### Skills

Skills are reusable prompt templates that extend Claude Code's capabilities.

| Skill | Description |
|-------|-------------|
| `config-sync` | Sync Claude Code configuration between local and remote |
| `continuous-learning` | Extract reusable knowledge from work sessions |
| ... | ... |

<For each skill, add a row with name and description extracted from SKILL.md>

### Commands

Custom slash commands for Claude Code.

| Command | Description |
|---------|-------------|
| `shareable-doc` | Generate high-density HTML documents for PDF export |
| ... | ... |

<For each command, add a row with name and brief description>

### Hooks

Event-driven scripts that run automatically.

| Hook | Trigger | Description |
|------|---------|-------------|
| `continuous-learning-activator.sh` | UserPromptSubmit | Activates continuous learning after each prompt |
| ... | ... | ... |

<For each hook, add a row>

### Status Line

Custom status line configuration showing working directory, git branch, model name, and context window.

**File:** `.claude/statusline-command.sh`

**Setup:** Add to `~/.claude/settings.json`:
```json
{
  "statusLine": {
    "type": "command",
    "command": "~/.claude/statusline-command.sh"
  }
}
```

## Installation

### Full Sync (Recommended)

Use the `/config-sync` skill to interactively sync configurations:

1. Install the config-sync skill manually (see Quick Start)
2. Run `/config-sync` in Claude Code
3. Select which features to install

### Manual Installation

Copy individual components:

```bash
# Skills
cp -r .claude/skills/SKILL_NAME ~/.claude/skills/

# Commands
cp .claude/commands/COMMAND.md ~/.claude/commands/

# Hooks
cp .claude/hooks/HOOK.sh ~/.claude/hooks/
chmod +x ~/.claude/hooks/HOOK.sh

# Status line
cp .claude/statusline-command.sh ~/.claude/
chmod +x ~/.claude/statusline-command.sh
```

## Contributing

Run `/config-sync` and select "push to remote" to contribute your local configurations.

---

*Last synced: <CURRENT_DATE>*
```

#### 7d: Commit README Update

If the README changed:

```bash
cd "$TEMP_DIR"
git add README.md
git diff --cached --quiet || git commit -m "Update README with current features"
git push origin main
```

### Step 8: Cleanup

Remove the temporary directory:

```bash
rm -rf "$TEMP_DIR"
```

### Step 9: Summary

Provide a summary of what was done:

```
## Sync Complete

**Installed from remote:**
- statusline-command.sh
- commands/shareable-doc.md

**Pushed to remote:**
- skills/my-skill

**README updated:** Yes (documented X skills, Y commands, Z hooks)

**Note:** Restart Claude Code for new configurations to take effect.
```

## Error Handling

- If git clone fails: Check network connectivity and repo URL
- If copy fails: Check permissions on ~/.claude/
- If push fails: Inform user about authentication requirements
- Always cleanup temp directory even on errors
- README update failures should not block the sync operation

## Notes

- This skill requires `git` to be installed
- Push functionality requires write access to the remote repository
- Skills that are git repos themselves (have .git folders) will be copied without their .git directory to avoid nested repos
- The comparison is based on file/directory names, not content (except for single files like statusline-command.sh where diff is used)
- README is regenerated from scratch each sync to ensure accuracy
- The README serves as the canonical documentation for what's in the repository
