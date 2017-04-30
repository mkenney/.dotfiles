#!/bin/zsh

## Find my full .zshrc at <github.com/mislav/dotfiles/blob/master/zshrc>.

# setup

autoload -U colors && colors
export LSCOLORS="ExGxcxdxcxegedcbcdacad"
setopt prompt_subst
source ~/.dotfiles/resources/color

# prompt

#ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[green]%}["
#ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
#ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}*%{$reset_color%}"
#ZSH_THEME_GIT_PROMPT_CLEAN=""

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=
GIT_PS1_SHOWUPSTREAM=1
#git_line=$(__git_ps1 '%s')
last_status=$?

# show git branch/tag, or name-rev if on detached head
parse_git_branch() {
  (command git symbolic-ref -q HEAD || command git name-rev --name-only --no-undefined --always HEAD) 2>/dev/null
}

# show red star if there are uncommitted changes
parse_git_dirty() {
  if command git diff-index --quiet HEAD 2> /dev/null; then
    echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
  else
    echo "$ZSH_THEME_GIT_PROMPT_DIRTY"
  fi
}

# if in a git repo, show dirty indicator + git branch
git_custom_status() {
  local git_where="$(parse_git_branch)"
  [ -n "$git_where" ] && echo "$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_PREFIX${git_where#(refs/heads/|tags/)}$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

# put fancy stuff on the right
#RPS1=`date "+%Y-%m-%d"`

#
# user/host/path status
#
__prompt_uid() {
    if [ "$EUID" = "0" ]; then # Root
        echo "
┌(${COLOR_RED_BLINK}%n${COLOR_YELLOW}@%M${COLOR_NORM}) - ${COLOR_NORM}%/${COLOR_NORM}"
    else
        echo "
┌(${COLOR_GREEN}%n${COLOR_YELLOW}@%M${COLOR_NORM}) - ${COLOR_NORM}%/${COLOR_NORM}"
    fi
}

__git_untracked() {
    echo $(git ls-files -o -d --exclude-standard | sed q | wc -l)
}

__git_status() {
    local output=0
    local modified=0
    local modified_str=
    local added=0
    local added_str=
    local renamed=0
    local renamed_str=
    local deleted=0
    local deleted_str=
    local untracked=0
    local untracked_str=
    local unstaged_str=
    local total=0
    local ahead_str=
    local behind_str=

    if [ "" != "$(git rev-list origin..HEAD)" ]; then
        ahead_str="<$(git rev-list origin..HEAD | wc | awk '{print $1}') "
        output=1
    fi

    if [ "" != "$(git rev-list HEAD..origin)" ]; then
        behind_str=">$(git rev-list HEAD..origin | wc | awk '{print $1}') "
        output=1
    fi

    if [ "" != "$(git diff --name-only)" ]; then
        unstaged_str="*$(git diff --name-only | wc | awk '{print $1}') "
        output=1
    fi

    while read line; do
        flag1=${line:0:1}
        flag2=${line:1:1}
        total=$((total + 1))
        if [ "?" = "$flag1" ] || [ "?" = "$flag2" ]; then
            untracked=$((untracked + 1))
            untracked_str="?$untracked "
            output=1
        fi
        if [ "A" = "$flag1" ] || [ "A" = "$flag2" ]; then
            added=$((added + 1))
            added_str="+$added "
            output=1
        fi
        if [ "D" = "$flag1" ] || [ "D" = "$flag2" ]; then
            deleted=$((deleted + 1))
            deleted_str="X$deleted "
            output=1
        fi
        if [ "M" = "$flag1" ] || [ "M" = "$flag2" ]; then
            modified=$((modified + 1))
            modified_str="≠$modified "
            output=1
        fi
        if [ "R" = "$flag1" ] || [ "R" = "$flag2" ]; then
            renamed=$((renamed + 1))
            renamed_str="⤿ $renamed "
            output=1
        fi
    done << EOF
$(git status --porcelain)
EOF

    total_str="#$total "
    if [ 0 -ne $output ]; then
        echo "$(echo -e " ahead: $ahead_str; output=$output ${ahead_str}${behind_str}${untracked_str}${added_str}${deleted_str}${renamed_str}${modified_str}${unstaged_str}${total_str}" | sed -e 's/[[:space:]]*$//')"
    fi
}

#
# git status line
#
__prompt_git() {
    # In a git repo
    if [ "" != "$(git rev-parse --git-dir 2> /dev/null)" ]; then
        branch=$(git rev-parse --abbrev-ref HEAD)
        echo "
├[%{${COLOR_BLUE_FADED}%}git: $branch$(__git_status)%{${COLOR_NORM}%}]"
    fi
}

__prompt_cmd() {
    if [ "0" = "$last_status" ]; then
        echo "
└(%{${COLOR_GREEN}%}%*%{${COLOR_NORM}%}) %F{240}(zsh)%f → "
    else
        # http://emojipedia.org/
        echo "
└(💀 ) %{%F{240}%}(zsh)%{${COLOR_NORM}%} ⤳ " # Last script exited with a non-zero code
    #ps1_lines+='\n└(🔴 ) %F240bash${COLOR_NORM} ⤳ ' # Last script exited with a non-zero code
    #ps1_lines+='\n└(‼️ ) %F240bash${COLOR_NORM} ⤳ ' # Last script exited with a non-zero code
    #ps1_lines+='\n└(❌ ) %F240bash${COLOR_NORM} ⤳ ' # Last script exited with a non-zero code
    #ps1_lines+='\n└(⛔ ) %F240bash${COLOR_NORM} ⤳ ' # Last script exited with a non-zero code
    #ps1_lines+='\n└(🚫 ) %F240bash${COLOR_NORM} ⤳ ' # Last script exited with a non-zero code
    fi
}
__zsh_prompt() {
    echo "$ps1_lines"
}
# basic prompt on the left
#PROMPT=$ps1_lines
PROMPT='$(__prompt_uid)$(__prompt_git)$(__prompt_cmd)'
