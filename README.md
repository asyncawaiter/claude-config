# Claude Config

Configuration and customizations for Claude Code CLI, including custom skills and status line setup.

## Installation

Clone this repo and follow the setup instructions for each component below.

```bash
git clone https://github.com/asyncawaiter/claude-config.git
```

---

## Status Line (Fish Shell + Tide)

A custom status line that displays working directory, git branch, model name, context window remaining, and vim mode.

### Prerequisites

- Fish shell
- [Tide prompt](https://github.com/IlanCosman/tide) (v5+)
- `jq` (for JSON parsing)

### Setup

1. **Copy the status line script:**

   ```bash
   cp .claude/statusline-command.sh ~/.claude/
   chmod +x ~/.claude/statusline-command.sh
   ```

2. **Configure Claude Code to use the status line:**

   Add the following to `~/.claude/settings.json`:

   ```json
   {
     "statusLine": {
       "type": "command",
       "command": "~/.claude/statusline-command.sh"
     }
   }
   ```

   Or merge with your existing settings if you have other configurations.

3. **Verify jq is installed:**

   ```bash
   # macOS
   brew install jq
   ```

### What the Status Line Shows

- **Cyan**: Current working directory (with `~` for home)
- **Green**: Git branch (if in a repo)
- **Magenta**: Model name in brackets
- **Additional**: Context window remaining percentage, vim mode (if enabled)

Example output:
```
~/projects/myapp (main) [Claude Opus 4.5] | ctx: 85%
```

---

## Custom Skills

Custom skills (slash commands) for Claude Code CLI.

### Installation

Copy the `.claude/commands/` folder to your project root, or symlink it globally:

```bash
cp -r .claude/commands ~/.claude/
```

### Available Skills

#### `/shareable-doc`

Generate high-density, professional HTML documents for PDF export.

**Features:**
- 3-color scheme (black, gray, teal)
- Compact layout optimized for print
- CSS-based flowcharts (no Unicode arrows)
- Print-safe backgrounds
- No emojis, no metadata headers

**Usage:** Run `/shareable-doc` in Claude Code to generate a report from your current context.
