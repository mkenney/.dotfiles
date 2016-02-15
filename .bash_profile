# ~/.bash_profile

# VIM stuff
if [ -f $PWD/.bash/vim ]; then
	. $PWD/.bash/vim
fi

# Git stuff
if [ -f $PWD/.bash/git ]; then
	. $PWD/.bash/git
fi

# Git completion
if [ -f $PWD/.bash/git-completion ]; then
	. $PWD/.bash/git-completion
fi

# Git prompt
if [ -f $PWD/.bash/git-prompt ]; then
	. $PWD/.bash/git-prompt
fi

# CVS stuff
if [ -f $PWD/.bash/cvs ]; then
	. $PWD/.bash/cvs
fi

# Docker stuff
if [ -f $PWD/.bash/docker ]; then
	. $PWD/.bash/docker
fi

# Perl stuff
if [ -f $PWD/.bash/perl ]; then
	. $PWD/.bash/perl
fi

# Java stuff
if [ -f $PWD/.bash/java ]; then
	. $PWD/.bash/java
fi

# Aliases
if [ -f $PWD/.bash/aliases ]; then
	. $PWD/.bash/aliases
fi

# Screen aliases
if [ -f $PWD/.bash/screen ]; then
	. $PWD/.bash/screen
fi

# SSH tunnel aliases
if [ -f ~/tunnels ]; then
	. ~/tunnels
fi

# Functions
if [ -f $PWD/.bash/functions ]; then
	. $PWD/.bash/functions
fi

# ENV
if [ -f $PWD/.bash/env ]; then
	. $PWD/.bash/env
fi

# Bash completion settings
if [ -f $PWD/.bash/completion ]; then
	. $PWD/.bash/completion
fi

# Sshfs mount aliases
if [ -f $PWD/.bash/mount ]; then
	. $PWD/.bash/mount
fi

# Prompt
if [ -f $PWD/.bash/prompt ]; then
	. $PWD/.bash/prompt
fi
