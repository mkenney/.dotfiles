#
# .bash/.bash_profile
#

#
# Load my VIM stuffs
#
if [ -f ~/.bash/.bash_vim ]; then
	. ~/.bash/.bash_vim
fi

#
# Load my gerrit stuffs
#
if [ -f ~/.bash/.bash_git ]; then
	. ~/.bash/.bash_git
fi

#
# Load git completion
#
if [ -f ~/.bash/.bash_git-completion ]; then
	. ~/.bash/.bash_git-completion
fi

#
# Load git prompt
#
if [ -f ~/.bash/.bash_git-prompt.sh ]; then
	. ~/.bash/.bash_git-prompt.sh
fi

#
# Load my cvs stuffs
#
if [ -f ~/.bash/.bash_cvs ]; then
	. ~/.bash/.bash_cvs
fi

#
# Docker stuff
#
if [ -f ~/.bash/.bash_docker ]; then
	. ~/.bash/.bash_docker
fi

#
# Load my perl stuffs
#
if [ -f ~/.bash/.bash_perl ]; then
	. ~/.bash/.bash_perl
fi

#
# Load my java stuffs
#
if [ -f ~/.bash/.bash_java ]; then
	. ~/.bash/.bash_java
fi

#
# Load my aliases
#
if [ -f ~/.bash/.bash_aliases ]; then
	. ~/.bash/.bash_aliases
fi

#
# Load my screen aliases
#
if [ -f ~/.bash/.bash_screen ]; then
	. ~/.bash/.bash_screen
fi

#
# SSH Tunnel aliases
#
if [ -f ~/.bash/.bash_tunnels ]; then
	. ~/.bash/.bash_tunnels
fi

#
# Load functions
#
if [ -f ~/.bash/.bash_functions ]; then
	. ~/.bash/.bash_functions
fi

#
# Load my env
#
if [ -f ~/.bash/.bash_env ]; then
	. ~/.bash/.bash_env
fi

#
# Load.bash/.bash completion settings
#
if [ -f ~/.bash/.bash_completion ]; then
	. ~/.bash/.bash_completion
fi

#
# Load Fuse4x mount aliases
#
if [ -f ~/.bash/.bash_mount ]; then
	. ~/.bash/.bash_mount
fi

#
# Load my prompt
#
if [ -f ~/.bash/.bash_prompt ]; then
	. ~/.bash/.bash_prompt
fi

