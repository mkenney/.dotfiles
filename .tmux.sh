#!/bin/bash
set -uo pipefail
IFS=$'\n\t'

SESSION=default

/usr/local/bin/tmux -2 attach-session -t $SESSION
if [ $? != 0 ]; then
    echo "initializing default session..."

    /usr/local/bin/tmux -2 new-session -d -s $SESSION

    /usr/local/bin/tmux rename-window     -t $SESSION:0 'scratch'
    /usr/local/bin/tmux new-window        -t $SESSION:1
    /usr/local/bin/tmux new-window        -t $SESSION:2
    /usr/local/bin/tmux new-window        -t $SESSION:3
    /usr/local/bin/tmux new-window        -t $SESSION:4
    /usr/local/bin/tmux new-window        -t $SESSION:5

    # set recently used order
    tmux select-window                    -t $SESSION:5
    tmux select-window                    -t $SESSION:4
    tmux select-window                    -t $SESSION:3
    tmux select-window                    -t $SESSION:2
    tmux select-window                    -t $SESSION:1
    tmux select-window                    -t $SESSION:0

    __startWatcher

    /usr/local/bin/tmux -2 attach-session -t $SESSION
fi
