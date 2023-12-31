
source ~/.dotfiles/shell/prompt/git-status
autoload -U colors && colors
autoload -U promptinit && promptinit
autoload -Uz vcs_info
export gitprompt=
export lastline=

precmd() {
    last_status=$?

    IN_GIT_REPO=$(/usr/bin/env git rev-parse --is-inside-work-tree 2> /dev/null)
    if [ "true" = "$IN_GIT_REPO" ]; then # In a git repo
        export gitprompt="
│ ${COLOR_BLUE_FADED}$(echo $(__git_status))${COLOR_NORM}"
    else
        export gitprompt=
    fi

    if [ "0" = "$last_status" ] || [ "" = "$last_status" ]; then
        export lastline="${COLOR_GREEN_FADED}%*${COLOR_NORM} → "
    else
        export lastline="${COLOR_GREEN_FADED}%*${COLOR_NORM} (${COLOR_RED_FADED}${last_status}${COLOR_NORM}) ⤳ "
    fi
}
chpwd() {
 }
zstyle ':vcs_info:git:*' formats '%b '
setopt PROMPT_SUBST
prompt fade red
source ~/.dotfiles/shell/common/color
PROMPT='
┌ ${COLOR_YELLOW_FADED}%n@%m${COLOR_NORM} - %d${gitprompt}
└ ${lastline}'

