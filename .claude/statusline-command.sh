#!/bin/bash

# Read JSON input from stdin
input=$(cat)

# Extract values
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // empty')
model=$(echo "$input" | jq -r '.model.display_name // .model // empty')
remaining=$(echo "$input" | jq -r '.context_window.remaining_percentage // empty')
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
context_size=$(echo "$input" | jq -r '.context_window.context_window_size // empty')
vim_mode=$(echo "$input" | jq -r '.vim.mode // empty')

# Shorten home directory
cwd_display="${cwd/#$HOME/~}"

# Get git branch if in a repo
git_branch=""
if git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
    branch=$(git -C "$cwd" branch --show-current 2>/dev/null)
    if [ -n "$branch" ]; then
        git_branch="$branch"
    fi
fi

# Build progress bar (10 chars wide) - shows USED percentage
progress_bar=""
if [ -n "$used_pct" ] && [ "$used_pct" != "null" ]; then
    # filled = used percentage / 10
    filled=$((used_pct / 10))
    empty=$((10 - filled))
    bar_fill=$(printf '%*s' "$filled" '' | tr ' ' '=')
    bar_empty=$(printf '%*s' "$empty" '')
    progress_bar="[${bar_fill}${bar_empty}]"
fi

# Format tokens as used/total (e.g., 28k/200k)
tokens_display=""
if [ -n "$context_size" ] && [ "$context_size" != "null" ]; then
    total_k=$((context_size / 1000))
    if [ -n "$used_pct" ] && [ "$used_pct" != "null" ]; then
        used_k=$((context_size * used_pct / 100 / 1000))
        tokens_display="${used_k}k/${total_k}k"
    else
        tokens_display="/${total_k}k"
    fi
fi

# Format vim mode
vim_info=""
if [ -n "$vim_mode" ]; then
    vim_info=" | [$vim_mode]"
fi

# Colors
CYAN="\033[36m"
YELLOW="\033[33m"
GREEN="\033[32m"
RESET="\033[0m"

# Build status line: Opus 4.5 [====      ] 14% | 28k/200k | master |
output="${CYAN}${model}${RESET}"

# Progress bar
if [ -n "$progress_bar" ]; then
    output="${output} ${progress_bar}"
fi

# Context USED percentage (yellow)
if [ -n "$used_pct" ] && [ "$used_pct" != "null" ]; then
    output="${output} ${YELLOW}${used_pct}%${RESET}"
fi

# Tokens used/total
if [ -n "$tokens_display" ]; then
    output="${output} | ${tokens_display}"
fi

# Git branch (green)
if [ -n "$git_branch" ]; then
    output="${output} | ${GREEN}${git_branch}${RESET}"
fi

output="${output}${vim_info}"

printf "%b" "$output"
