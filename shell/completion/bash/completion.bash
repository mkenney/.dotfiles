#!/usr/bin/env bash

if [ "$(uname)" = 'Linux' ]; then
    # disable spelling correction
    shopt -u dirspell
fi

# enable pathname expansion
#shopt -s globstar

# Include dotfiles in filename expansion
shopt -s dotglob

# Enable alias name expansion
shopt -s expand_aliases

# Enable extended pattern matching: http://en.chys.info/2009/02/extglob/
shopt -s nocaseglob

# Case-insensitive auto-completion
#set completion-ignore-case On

# Tab completion for sudo
complete -cf sudo

# Tab completion for which
complete -cf which

# Tab completion for man
complete -cf man

# /etc/hosts, ~/.ssh/config, and ~/.ssh/known_hosts hostname completion
function __completeHosts {
	COMPREPLY=()
	cur="${COMP_WORDS[COMP_CWORD]}"

    config_hosts=$([ -f "$HOME/.ssh/config" ] && cat $HOME/.ssh/config | grep -e "^Host " | awk '{print $2}')
    etc_hosts=$(cat /etc/hosts | grep -e "^[0-9]{3}\." | awk '{print $2}')
    known_hosts=$([ -f "$HOME/.ssh/config" ] && cat $HOME/.ssh/known_hosts | awk '{print $1}' | sort | uniq)

	COMPREPLY=($(compgen -W "$config_hosts $etc_hosts $known_hosts" -- $cur))
	return 0
}
complete -o default -o dirnames -o filenames -F __completeHosts \
    curl \
    dig \
    ftp \
    links \
    lynx \
    ping \
    rsync \
    scp \
    sftp \
    ssh \
    telnet \
    wget
