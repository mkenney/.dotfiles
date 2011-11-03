#
# Platform specific aliases
#
platform=`uname`
if [[ $platform == 'Linux' ]]; then
	alias ls='ls -aF --time-style=+"%a %Y-%m-%d %T" --color=auto'

elif [[ $platform == 'Darwin' ]]; then
	alias ls='ls -GAaF'
fi

#
# Other aliases
#
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ll='ls -l'
alias l='ls -1'
alias e='exit'
alias cls='clear'
alias csl='clear'
alias pico='nano'
alias pioc='nano'
alias pcio='nano'
alias pcoi='nano'
alias vi='vim'
alias more='less'
alias md='mkdir'
alias grep='grep -n --color=auto'
alias top='htop -d 5'
alias suod='sudo'
alias tail='tail -25'
alias locate='locate -i'
alias pstree='pstree -lpuU'
alias sr='screen -U -A -T screen-256color -d -R'
alias busy='while [ TRUE ]; do head -n 100 /dev/urandom; sleep .1; done | hexdump -C | grep --color=none "ca fe"'

