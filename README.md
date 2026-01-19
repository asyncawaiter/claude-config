# Claude Config

Personal Claude Code configuration repository. Clone and use `/config-sync` to sync with your local machine.

## Quick Start

```bash
# Clone this repo
git clone https://github.com/asyncawaiter/claude-config.git

# Copy the config-sync skill to enable syncing
mkdir -p ~/.claude/skills
cp -r claude-config/.claude/skills/config-sync ~/.claude/skills/

# Run the sync command in Claude Code
/config-sync
```

## Features

### Skills

Skills are reusable prompt templates that extend Claude Code's capabilities. Install to `~/.claude/skills/`.

| Skill | Description |
|-------|-------------|
| `config-sync` | Sync Claude Code configuration between local machine and remote GitHub repo. Compares skills, commands, hooks, and statusline, allowing selective sync in both directions. |
| `continuous-learning` | Continuous learning system that extracts reusable knowledge from work sessions. Triggers on `/continuous-learning`, "save this as a skill", "what did we learn?", or after non-obvious debugging tasks. |
| `effective-writing-llms` | Write effectively in the age of LLMs, avoiding common machine-generated patterns while leveraging AI as a writing tool. Use for documentation, reports, and analyses. |
| `humanizer` | Remove signs of AI-generated writing from text. Detects and fixes patterns including inflated symbolism, promotional language, em dash overuse, rule of three, AI vocabulary, and excessive conjunctive phrases. |

### Commands

Custom slash commands for Claude Code. Install to `~/.claude/commands/`.

| Command | Description |
|---------|-------------|
| `shareable-doc` | Generate high-density, professional HTML documents for PDF export. Features a strict 3-color design (black, gray, teal), CSS-based flowcharts, compact layout, and print optimization. |

### Hooks

Event-driven scripts that run automatically. Install to `~/.claude/hooks/`.

| Hook | Trigger | Description |
|------|---------|-------------|
| `continuous-learning-activator.sh` | UserPromptSubmit | Activates continuous learning evaluation after each prompt, ensuring valuable knowledge is captured and preserved. |

### Status Line

Custom status line showing working directory, git branch, model name, and context window remaining.

**File:** `.claude/statusline-command.sh`

**Display format:**
```
~/projects/myapp (main) [Claude Opus 4.5] | ctx: 85%
```

**Setup:** Add to `~/.claude/settings.json`:
```json
{
  "statusLine": {
    "type": "command",
    "command": "~/.claude/statusline-command.sh"
  }
}
```

**Prerequisites:** `jq` must be installed (`brew install jq` on macOS)

## Installation

### Full Sync (Recommended)

Use the `/config-sync` skill to interactively sync configurations:

1. Install the config-sync skill manually (see Quick Start)
2. Run `/config-sync` in Claude Code
3. Select which features to install from remote
4. Optionally push your local configurations to share

### Manual Installation

Copy individual components:

```bash
# Skills (directories)
cp -r .claude/skills/SKILL_NAME ~/.claude/skills/

# Commands (markdown files)
mkdir -p ~/.claude/commands
cp .claude/commands/COMMAND.md ~/.claude/commands/

# Hooks (shell scripts)
mkdir -p ~/.claude/hooks
cp .claude/hooks/HOOK.sh ~/.claude/hooks/
chmod +x ~/.claude/hooks/HOOK.sh

# Status line
cp .claude/statusline-command.sh ~/.claude/
chmod +x ~/.claude/statusline-command.sh
```

## Contributing

Run `/config-sync` and select "push to remote" to contribute your local configurations back to this repository.

## Structure

```
.claude/
├── commands/           # Slash command definitions (.md)
│   └── shareable-doc.md
├── hooks/              # Event-triggered scripts (.sh)
│   └── continuous-learning-activator.sh
├── skills/             # Skill directories with SKILL.md
│   ├── config-sync/
│   ├── continuous-learning/
│   ├── effective-writing-llms/
│   └── humanizer/
└── statusline-command.sh  # Custom status line script
```

---

*Last synced: 2026-01-19*
