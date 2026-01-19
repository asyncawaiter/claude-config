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

### Step 7: Cleanup

Remove the temporary directory:

```bash
rm -rf "$TEMP_DIR"
```

### Step 8: Summary

Provide a summary of what was done:

```
## Sync Complete

**Installed from remote:**
- statusline-command.sh
- commands/shareable-doc.md

**Pushed to remote:**
- (none)

**Note:** Restart Claude Code for new configurations to take effect.
```

## Error Handling

- If git clone fails: Check network connectivity and repo URL
- If copy fails: Check permissions on ~/.claude/
- If push fails: Inform user about authentication requirements
- Always cleanup temp directory even on errors

## Notes

- This skill requires `git` to be installed
- Push functionality requires write access to the remote repository
- Skills that are git repos themselves (have .git folders) will be copied without their .git directory to avoid nested repos
- The comparison is based on file/directory names, not content (except for single files like statusline-command.sh where diff is used)
