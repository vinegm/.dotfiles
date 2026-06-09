#!/usr/bin/env bash

# Credits to my boy ThePrimeagen for the original script/idea:
# https://github.com/ThePrimeagen/.dotfiles/blob/master/bin/.local/scripts/tmux-sessionizer

tmux_running=$(pgrep tmux)

existing_sessions=()
if [[ -n $tmux_running ]]; then
    while IFS= read -r s; do
        existing_sessions+=("$s")
    done < <(tmux list-sessions -F '#{session_name}' 2>/dev/null)
fi

if [[ $# -eq 1 ]]; then
    selected=$1
else
    repo_dirs=$(find ~/repos -mindepth 1 -maxdepth 1 -type d)

    selected=$({
        printf '%s\n' "$repo_dirs"
        printf '%s\n' "${existing_sessions[@]}"
    } | fzf --preview '
        if [[ -d {} ]]; then
            ls --color=always {}
        else
            tmux list-windows -t {} 2> /dev/null
        fi
        ')
fi

if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s "$selected_name" -c "$selected"
    exit 0
fi

if ! tmux has-session -t="$selected_name" 2>/dev/null; then
    tmux new-session -ds "$selected_name" -c "$selected"
fi

tmux switch-client -t "$selected_name"
