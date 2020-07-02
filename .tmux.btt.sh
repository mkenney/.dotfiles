#!/usr/bin/env bash

SESSION=default
echo $(tmux list-windows -t $SESSION | awk '{print $2}')

if [ "" = "$(tmux list-windows -t default | grep "can't find session")" ]; then
    echo 'n/a'
else
    echo $(tmux list-windows -t $SESSION | awk '{print $2}')
fi

windows=$(tmux list-windows -t $SESSION | awk '{print $2}')
$(echo $windows | grep "can't find session" > /dev/null)
if [ "0" = "$?" ]; then
    echo $windows;
else
    echo 'n/a'
fi

if [ "" != "$(/usr/local/bin/tmux list-windows -t default | grep "can't find session")" ]; then
    echo 'n/a'
else
    echo $(/usr/local/bin/tmux list-windows -t default | awk '{print $2}')
fi
