
source ~/.dotfiles/shell/prompt/git-status
source ~/.dotfiles/shell/prompt/k8s-status
source ~/.dotfiles/shell/common/color

topline="┌ %d"
midline=
statusline=
# surround escape sequences in '%{${sequences_here}%}' to ignore their width properly
precmd() {
    last_exit_code=$?

    declare -a tool_states
    statusline=

    # k8s status
    k8s_status=$(__k8s_status)
    if [ "" != "$k8s_status" ]; then
        tool_states+=("%{${COLOR_DKGREEN_FADED}%}${z}%{${COLOR_NORM}%}")
    fi

    # git status
    in_git_repo=$(/usr/bin/env git rev-parse --is-inside-work-tree 2> /dev/null)
    if [ "true" = "$in_git_repo" ]; then # In a git repo
        tool_states+=("%{${COLOR_BLUE_FADED}%}$(echo $(__git_status))%{${COLOR_NORM}%}")
    fi

    # define midline (tool states)
    if [ "" != "$tool_states" ]; then
        #midline=$(printf "\n│ ${tool_states}")
        midline=" ${tool_states}"
    else
        midline=
    fi

    # define command prompt
    if [ "0" = "$last_exit_code" ] || [ "" = "$last_exit_code" ]; then
        statusline="└ %{${COLOR_GREEN_FADED}%}%*%{${COLOR_NORM}%}${midline} → %{$(echo -e -n "\x1b[\x35 q")%}"
    else
        statusline="└ %{${COLOR_GREEN_FADED}%}%*%{${COLOR_NORM}%}${midline} (%{${COLOR_RED_FADED}%}${last_exit_code}%{${COLOR_NORM}%}) ⤳ %{$(echo -e -n "\x1b[\x35 q")%}"
    fi
}

#chpwd() {}

setopt PROMPT_SUBST
PROMPT='
${topline}
${statusline}'

