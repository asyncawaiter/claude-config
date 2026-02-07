---
name: init-project
description: |
  Scaffold a new project with a CLAUDE.md containing workflow orchestration rules,
  task management guidelines, and core principles. Use when starting a new project
  that you intend to build with Claude Code. Invoke with /init-project.
author: abhishek
version: 1.0.0
allowed-tools:
  - Read
  - Write
  - Bash
---

# Init Project Skill

When this skill is invoked, write a `CLAUDE.md` file in the current working directory with the content below. If a `CLAUDE.md` already exists, warn the user and ask before overwriting.

Also create a `tasks/` directory with empty `todo.md` and `lessons.md` files if they don't already exist.

## CLAUDE.md Content

Write exactly this content to `CLAUDE.md`:

```markdown
# Workflow Orchestration

## 1. Plan Mode Default

- Enter plan mode for ANY non-trivial task (3+ steps or architectural decisions)
- If something goes sideways, STOP and re-plan immediately - don't keep pushing
- Use plan mode for verification steps, not just building
- Write detailed specs upfront to reduce ambiguity

## 2. Subagent Strategy

- Use subagents liberally to keep main context window clean
- Offload research, exploration, and parallel analysis to subagents
- For complex problems, throw more compute at it via subagents
- One task per subagent for focused execution
- Orchestrator role: Break problems into structured task lists with dependencies (use addBlockedBy), then assign subagents systematically — show the dependency graph before coding begins

## 3. Self-Improvement

- After corrections, update your approach permanently
- Track patterns in mistakes and proactively avoid them
- When something works well, note it for future reference

## 4. Autonomous Bug Fixing

- When given a bug report: just fix it. Don't ask for hand-holding
- Point at logs, errors, failing tests - then resolve them
- Zero context switching required from the user
- Go fix failing CI tests without being told how

# Task Management

- **Plan First:** Write plan to tasks/todo.md with checkable items; use TaskCreate with proper addBlockedBy dependencies
- **Verify Plan:** Show task list with blocked-by relationships before starting implementation
- **Assign & Orchestrate:** Delegate tasks to subagents systematically; main agent becomes orchestrator
- **Track Progress:** Mark items complete as you go
- **Explain Changes:** High-level summary at each step
- **Document Results:** Add review section to tasks/todo.md
- **Capture Lessons:** Update tasks/lessons.md after corrections

# Core Principles

- **Simplicity First:** Make every change as simple as possible. Impact minimal code.
- **No Laziness:** Find root causes. No temporary fixes. Senior developer standards.
- **Minimal Impact:** Changes should only touch what's necessary. Avoid introducing bugs.

# Teammate Coordination

## Spawning

- Teammates spawned via `Task` tool with `team_name` land in tmux but **sit idle at the welcome prompt** — they do NOT auto-execute their initial prompt
- After spawning, you MUST manually kick them off:
  1. Read the team config (`~/.claude/teams/<team-name>/config.json`) to get each teammate's `tmuxPaneId`
  2. Send the prompt via `tmux send-keys -t %<PANE_ID> 'your prompt text' Enter`
  3. Send a second `Enter` keystroke: `tmux send-keys -t %<PANE_ID> Enter` — the first Enter becomes a newline in the input, the second submits it
- Inbox messages go unread until the teammate completes at least one conversation turn, so `SendMessage` alone won't wake a freshly spawned teammate

## Communication

- After a teammate's first turn, `SendMessage` works normally — idle teammates wake up when a message arrives
- Monitor teammate progress via `tmux capture-pane -t %<PANE_ID> -p -S -30` and `TaskList`
- If a teammate goes idle unexpectedly, check the tmux pane before re-sending messages

## Shutdown & Cleanup

- Send `/exit` via `tmux send-keys -t %<PANE_ID> '/exit' Enter` then a second `Enter` to submit
- After exit, kill the shell pane: `tmux kill-pane -t %<PANE_ID>`
- The `Teammate cleanup` tool may refuse if it still sees active members — after killing panes, `rm -rf ~/.claude/teams/<team-name> ~/.claude/tasks/<team-name>` works

## File Conflict Avoidance

- When teammates edit the same file, set `addBlockedBy` dependencies so they work sequentially on overlapping regions
- Keep teammate scopes to non-overlapping files when possible
```

## Tasks Directory Setup

After writing CLAUDE.md, create the tasks directory:

- `tasks/todo.md` — with a header `# TODO` and empty checklist placeholder
- `tasks/lessons.md` — with a header `# Lessons Learned`

Only create these if they don't already exist.

## Confirmation

After completing, tell the user:
- CLAUDE.md has been created
- tasks/ directory has been scaffolded
- They can customize the CLAUDE.md further as the project evolves
