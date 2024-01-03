
source ~/.dotfiles/shell/prompt/git-status
source ~/.dotfiles/shell/prompt/k8s-status
source ~/.dotfiles/shell/common/color

# surround escape sequences in '%{${sequences_here}%}' to ignore their width properly
topline="┌ %{${COLOR_YELLOW_FADED}%}20%D%{${COLOR_NORM}%} %d"
midline=
promptline=

precmd() {
    last_exit_code=$?

    declare -a tool_states
    promptline=

    # k8s status
    k8s_status=$(__k8s_status)
    if [ "" != "$k8s_status" ]; then
        tool_states+=("%{${COLOR_DKGREEN_FADED}%}%{${K8S_PS1_SYMBOL}%G%} ${k8s_status}%{${COLOR_NORM}%}")
    fi

    # git status
    in_git_repo=$(/usr/bin/env git rev-parse --is-inside-work-tree 2> /dev/null)
    if [ "true" = "$in_git_repo" ]; then # In a git repo
        tool_states+=("%{${COLOR_BLUE_FADED}%}$(echo $(__git_status))%{${COLOR_NORM}%}")
    fi

    # define midline (tool states)
    if [ "" != "$tool_states" ]; then
        #statusline=$(printf "\n│ ${tool_states}")
        statusline=" ${tool_states}"
    else
        statusline=
    fi

    # define command prompt
    if [ "0" = "$last_exit_code" ] || [ "" = "$last_exit_code" ]; then
        promptline="└ %{${COLOR_GREEN_FADED}%}%D{%H:%M:%S}%{${COLOR_NORM}%}${statusline} → %{$(echo -e -n "\x1b[\x35 q")%}"
    else
        promptline="└ %{${COLOR_GREEN_FADED}%}%D{%H:%M:%S}%{${COLOR_NORM}%}${statusline} (%{${COLOR_RED_FADED}%}${last_exit_code}%{${COLOR_NORM}%}) ⤳ %{$(echo -e -n "\x1b[\x35 q")%}"
    fi
}

#chpwd() {}

setopt PROMPT_SUBST
PROMPT='
${topline}
${promptline}'

