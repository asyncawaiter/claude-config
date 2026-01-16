# Claude Skills

Custom skills (slash commands) for Claude Code CLI.

## Installation

Copy the `.claude/commands/` folder to your project root, or symlink it globally.

## Available Skills

### `/shareable-doc`
Generate high-density, professional HTML documents for PDF export.

**Features:**
- 3-color scheme (black, gray, teal)
- Compact layout optimized for print
- CSS-based flowcharts (no Unicode arrows)
- Print-safe backgrounds
- No emojis, no metadata headers

**Usage:** Run `/shareable-doc` in Claude Code to generate a report from your current context.
