#!/usr/bin/env bash

# Credits to my boy ThePrimeagen for the original script/idea:
# https://github.com/ThePrimeagen/.dotfiles/blob/master/bin/.local/scripts/tmux-sessionizer

# Dirs probed for git repos
search_dirs=(
    ~/repos
    ~/work
)

search_depth=3

# Unmatched globs expand to nothing,
# so find_repos skips empty dirs
shopt -s nullglob

# Print git repos at most $1 levels below
# the given dirs, stops at a git repo
find_repos() {
    local depth=$1 dir
    shift

    ((depth < 0)) && return

    for dir in "$@"; do
        dir=${dir%/}

        if [[ -e $dir/.git ]]; then
            echo "$dir"
            continue
        fi

        find_repos $((depth - 1)) "$dir"/*/
    done
}

# Pick a repo or a running session with fzf
pick() {
    {
        tmux list-sessions -F '#{session_name}' 2>/dev/null
        find_repos "$search_depth" "${search_dirs[@]}"
    } | fzf --preview '
        tmux capture-pane -ep -t "="{}":" 2> /dev/null ||
        ~/.local/bin/fzf-previewer.sh {}
    '
}

selected=${1:-$(pick)}
[[ -z $selected ]] && exit 0

session=$(basename "$selected" | tr . _)

if ! tmux has-session -t="$session" 2>/dev/null; then
    tmux new-session -ds "$session" -c "$selected"
fi

if [[ -n $TMUX ]]; then
    tmux switch-client -t "$session"
else
    tmux attach-session -t "$session"
fi
