#!/bin/bash

# This allows you to pull all repos
# Allows passing of a ssh key as the
# first arg to not ask password on
# every pull.
# **Not made with monorepos in mind.**

if [ $1 ]; then
    eval $(ssh-agent -s)

    if ! [ -f "$1" ]; then
        echo "Not an ssh key"
        exit 1
    fi

    ssh-add "$1"
fi

function pull_repos() {
    if ! [ -d ".git" ]; then
        for subdir in */; do
            [ -d "$subdir" ] || continue
            cd "$subdir" || continue

            pull_repos
            cd .. || exit
        done
        return
    fi

    echo "Pulling in $(pwd)"
    git pull
}

pull_repos

if [ $SSH_AGENT_PID ]; then
    kill $SSH_AGENT_PID
fi

