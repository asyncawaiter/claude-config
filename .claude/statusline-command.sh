#!/bin/bash

# Read JSON input from stdin
input=$(cat)

# Extract values
cwd=$(echo "$input" | jq -r '.workspace.current_dir')
model=$(echo "$input" | jq -r '.model.display_name')
remaining=$(echo "$input" | jq -r '.context_window.remaining_percentage // empty')
vim_mode=$(echo "$input" | jq -r '.vim.mode // empty')

# Shorten home directory
cwd_display="${cwd/#$HOME/~}"

# Get git branch if in a repo
git_branch=""
if git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
    branch=$(git -C "$cwd" branch --show-current 2>/dev/null)
    if [ -n "$branch" ]; then
        git_branch=" ($branch)"
    fi
fi

# Format context info
context_info=""
if [ -n "$remaining" ]; then
    context_info=" | ctx: ${remaining}%"
fi

# Format vim mode
vim_info=""
if [ -n "$vim_mode" ]; then
    vim_info=" | $vim_mode"
fi

# Build status line with colors
# Cyan for directory, Green for git branch, Magenta for model
printf "\033[36m%s\033[0m\033[32m%s\033[0m \033[35m[%s]\033[0m%s%s" \
    "$cwd_display" \
    "$git_branch" \
    "$model" \
    "$context_info" \
    "$vim_info"
