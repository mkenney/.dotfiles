# ~/.bash_profile

# VIM stuff
if [ -f ~/.bash/.bash_vim ]; then
	. ~/.bash/.bash_vim
fi

# Git stuff
if [ -f ~/.bash/.bash_git ]; then
	. ~/.bash/.bash_git
fi

# Git completion
if [ -f ~/.bash/.bash_git-completion ]; then
	. ~/.bash/.bash_git-completion
fi

# Git prompt
if [ -f ~/.bash/.bash_git-prompt.sh ]; then
	. ~/.bash/.bash_git-prompt.sh
fi

# CVS stuff
if [ -f ~/.bash/.bash_cvs ]; then
	. ~/.bash/.bash_cvs
fi

# Docker stuff
if [ -f ~/.bash/.bash_docker ]; then
	. ~/.bash/.bash_docker
fi

# Perl stuff
if [ -f ~/.bash/.bash_perl ]; then
	. ~/.bash/.bash_perl
fi

# Java stuff
if [ -f ~/.bash/.bash_java ]; then
	. ~/.bash/.bash_java
fi

# Aliases
if [ -f ~/.bash/.bash_aliases ]; then
	. ~/.bash/.bash_aliases
fi

# Screen aliases
if [ -f ~/.bash/.bash_screen ]; then
	. ~/.bash/.bash_screen
fi

# SSH tunnel aliases
if [ -f ~/.bash_tunnels ]; then
	. ~/.bash_tunnels
fi

# Functions
if [ -f ~/.bash/.bash_functions ]; then
	. ~/.bash/.bash_functions
fi

# ENV
if [ -f ~/.bash/.bash_env ]; then
	. ~/.bash/.bash_env
fi

# Bash completion settings
if [ -f ~/.bash/.bash_completion ]; then
	. ~/.bash/.bash_completion
fi

# Sshfs mount aliases
if [ -f ~/.bash/.bash_mount ]; then
	. ~/.bash/.bash_mount
fi

# Prompt
if [ -f ~/.bash/.bash_prompt ]; then
	. ~/.bash/.bash_prompt
fi
