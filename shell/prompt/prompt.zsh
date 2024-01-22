
source ~/.dotfiles/shell/prompt/git-status
source ~/.dotfiles/shell/prompt/k8s-status
source ~/.dotfiles/shell/common/color

# surround escape sequences in '%{${sequences_here}%}' to ignore their width properly
precmd() {
    last_exit_code=$?

    prompt_beg="┌ "
    prompt_mid="├ "
    prompt_end="└"
    #prompt_sep=" ⋅ "
    #prompt_sep=" ⎖"
    #prompt_sep=" ⦀ "
    #prompt_sep=" ჻ "
    prompt_sep=" • "
    #prompt_std="→"
    prompt_std=">"
    #prompt_err="⤳"
    #prompt_err="↯"
    #prompt_err="⇨"
    #prompt_err="▷"
    prompt_err=">"
    #"↷ ↹ ↻ ↺ ⇉ ⇌ ⇢ ⇛ ⇝ ⇨ ⇰ ⇸"
    #window_padding=8 # columns of padding in the terminal window width
    width="$((($COLUMNS / 3) * 2))" # COLUMNS is the terminal width tracked by zsh, instead of `tput cols`

    declare -a tool_states
    declare -a lines

    # Line 1, date
    header=("%{${COLOR_GREEN_FADED}%}%*%{${COLOR_NORM}%}")

    # State 1, pwd relative in src directories
    pwd="$(pwd)"
    in_git_repo=$(/usr/bin/env git rev-parse --is-inside-work-tree 2> /dev/null)
    if [ "true" = "$in_git_repo" ]; then # In a git repo
        pwd=$(echo $pwd | sed -r 's#.*/(github\.com\/.*).*#\1#')
    fi
    tool_states+=("$pwd")

    # State 2, git
    if [ "true" = "$in_git_repo" ]; then # In a git repo
        tool_states+=("%{${COLOR_BLUE_FADED}%}$(echo $(__git_status))%{${COLOR_NORM}%}")
    fi

    # State 3, k8s
    k8s_status=$(__k8s_status)
    if [ "" != "$k8s_status" ]; then
        tool_states+=("%{${COLOR_DKGREEN_FADED}%}%{${K8S_PS1_SYMBOL}%G%} ${k8s_status}%{${COLOR_NORM}%}")
    fi

    str=$header
    prefix=$prompt_beg
    for state in $tool_states; do
        raw_str="$(echo "${str}${prompt_sep}${state}" | sed 's/[^[:print:]]\[[^a-zA-Z]*[a-zA-Z]//g' | sed 's/\(%{\|%}\|%G\)//g')"
        if [ "${#raw_str}" -lt "$width" ]; then
            str="${str}${prompt_sep}${state}"
        else
            lines+=("${prefix}${str}")
            prefix=$prompt_mid
            str=$state
        fi
    done
    if [ "" != "$str" ]; then lines+=("${prefix}${str}"); fi

    # define command prompt
    if [ "0" = "$last_exit_code" ] || [ "" = "$last_exit_code" ]; then
        lines+=("${prompt_end}${prompt_std} %{$(echo -e -n "\x1b[\x35 q")%}")
    else
        lines+=("${prompt_end}(%{${COLOR_RED_FADED}%}${last_exit_code}%{${COLOR_NORM}%})${prompt_err} %{$(echo -e -n "\x1b[\x35 q")%}")
    fi

    OLDIFS=$IFS
    IFS=$'\n'
    prompttext="$lines"
    IFS=$OLDIFS
}

# trap SIGWINCH when the terminal is resized
TRAPWINCH () {
    precmd
    PROMPT='
${prompttext}'
}

#chpwd() {}

setopt PROMPT_SUBST
PROMPT='
${prompttext}'

