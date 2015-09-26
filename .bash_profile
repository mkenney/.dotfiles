# ~/.bash_profile

# VIM stuff
if [ -f ~/.bash/vim ]; then
	. ~/.bash/vim
fi

# Git stuff
if [ -f ~/.bash/git ]; then
	. ~/.bash/git
fi

# Git completion
if [ -f ~/.bash/git-completion ]; then
	. ~/.bash/git-completion
fi

# Git prompt
if [ -f ~/.bash/git-prompt ]; then
	. ~/.bash/git-prompt
fi

# CVS stuff
if [ -f ~/.bash/cvs ]; then
	. ~/.bash/cvs
fi

# Docker stuff
if [ -f ~/.bash/docker ]; then
	. ~/.bash/docker
fi

# Perl stuff
if [ -f ~/.bash/perl ]; then
	. ~/.bash/perl
fi

# Java stuff
if [ -f ~/.bash/java ]; then
	. ~/.bash/java
fi

# Aliases
if [ -f ~/.bash/aliases ]; then
	. ~/.bash/aliases
fi

# Screen aliases
if [ -f ~/.bash/screen ]; then
	. ~/.bash/screen
fi

# SSH tunnel aliases
if [ -f ~/tunnels ]; then
	. ~/tunnels
fi

# Functions
if [ -f ~/.bash/functions ]; then
	. ~/.bash/functions
fi

# ENV
if [ -f ~/.bash/env ]; then
	. ~/.bash/env
fi

# Bash completion settings
if [ -f ~/.bash/completion ]; then
	. ~/.bash/completion
fi

# Sshfs mount aliases
if [ -f ~/.bash/mount ]; then
	. ~/.bash/mount
fi

# Prompt
if [ -f ~/.bash/prompt ]; then
	. ~/.bash/prompt
fi
