#!/usr/bin/env bash

set -uo pipefail
IFS=$'\n\t'

SESSION=default

env tmux -2 attach-session -t $SESSION
if [ $? != 0 ]; then
    echo "initializing default session..."

    env tmux -2 new-session -d -s $SESSION

    env tmux rename-window     -t $SESSION:0 'scratch'
    env tmux new-window        -t $SESSION:1
    env tmux new-window        -t $SESSION:2
    env tmux new-window        -t $SESSION:3
    env tmux new-window        -t $SESSION:4
    env tmux new-window        -t $SESSION:5

    # set recently used order
    tmux select-window                    -t $SESSION:5
    tmux select-window                    -t $SESSION:4
    tmux select-window                    -t $SESSION:3
    tmux select-window                    -t $SESSION:2
    tmux select-window                    -t $SESSION:1
    tmux select-window                    -t $SESSION:0

    __startWatcher

    env tmux -2 attach-session -t $SESSION
fi
