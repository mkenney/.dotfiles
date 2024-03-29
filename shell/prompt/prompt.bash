#!/usr/bin/env bash

#
# Set the bash prompt
# https://wiki.archlinux.org/index.php/Color_Bash_Prompt
#

# Load color definitions
source ~/.dotfiles/common/color

export LAST_PWD=$PWD
export IN_GIT_REPO=$(git rev-parse --is-inside-work-tree 2> /dev/null)

__prompt_command() {
    # always first to capture the last shell error
    local last_status=$?

    local -a ps1_lines

    # detect ssh sessions
    ssh=
    if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
        ssh=1
    else
        case $(ps -o comm= -p $PPID) in sshd|*/sshd)
            ssh=1;;
        esac
    fi

    session_type=
    if [ "1" == "$ssh" ]; then
        session_type=' \[${COLOR_DKGREEN_FADED}\](ssh)\[${COLOR_NORM}\]'
    fi

    userprompt=
    if [ "$EUID" = "0" ]; then
        # Root
        userprompt="${COLOR_RED_BLINK}\]\u\[\e[0m\]\[${COLOR_NORM}\]"
    elif [ "true" = "$IS_DEVENV" ]; then
        userprompt="\[\033[38;5;88m\](devenv)\[${COLOR_NORM}\]"
    else
        userprompt="${COLOR_YELLOW_FADED}\]\u\[${COLOR_NORM}\]"
    fi

    hostprompt=
    if [ "true" != "$IS_DEVENV" ]; then
        hostprompt="\[${COLOR_YELLOW_FADED}\]@\H\[${COLOR_NORM}\]"
    fi

    pwdprompt="\[${COLOR_NORM_FADED}\]$PWD\[${COLOR_NORM}\]"


    #if [ "true" = "$IS_DEVENV" ]; then
    #    ps1_lines+="${session_type} - \[${COLOR_NORM_FADED}\]$PWD\[${COLOR_NORM}\]"
    #else
    #    ps1_lines+="\[${COLOR_YELLOW_FADED}\]@\H\[${COLOR_NORM}\]${session_type} - \[${COLOR_NORM_FADED}\]$PWD\[${COLOR_NORM}\]"
    #fi

    # k8s status line
    k8sprompt=
    if [ "enabled" = "$K8S_STATUS_LINE" ]; then
        k8sprompt="\[${COLOR_DKGREEN_FADED}\]$(__k8s_ps1)\[${COLOR_NORM}\] "
    fi

    # git status line
    gitprompt=
    if [ "$LAST_PWD" != "$PWD" ]; then
        export IN_GIT_REPO=$(git rev-parse --is-inside-work-tree 2> /dev/null)
    fi
    if [ "true" = "$IN_GIT_REPO" ]; then # In a git repo
        gitprompt="\[${COLOR_BLUE_FADED}\]$(__git_status)\[${COLOR_NORM}\]"
    fi

    # Line 1 - host info, current path
    ps1_lines+="\n┌${userprompt}${hostprompt}${session_type} - ${pwdprompt}"

    # Line 2 - k8s / git status
    if [ "" != "$k8sprompt" ] || [ "" != "$gitprompt" ]; then
        ps1_lines+="\n│${k8sprompt}${gitprompt}"
    fi

    # Line 3 - time and error state
    if [ "0" == "$last_status" ] || [ "" == "$last_status" ]; then
        # no current error code
        ps1_lines+="\n└\[${COLOR_GREEN_FADED}\]\t\[${COLOR_NORM}\] → "
    else
        # last script exited with a non-zero code
        ps1_lines+="\n└\[${COLOR_GREEN_FADED}\]\t\[${COLOR_NORM}\] (\[${COLOR_RED_FADED}\]$last_status\[${COLOR_NORM}\]) ⤳ "
    fi

    # Make the cursor a blinking vertical line
    # http://stackoverflow.com/questions/4416909/anyway-change-the-cursor-vertical-line-instead-of-a-box
    ps1_lines+=$(echo -e -n "\[\x1b[\x35 q\]")

    export LAST_PWD=$PWD
    PS1="${ps1_lines[*]}"
}
export PROMPT_COMMAND=__prompt_command

export PS2='\[${COLOR_NORM_BOLD}\]\>\[${COLOR_NORM}\] '
