# ~/.bash_profile

# VIM stuff
if [ -f ~/.dotfiles/resources/vim ]; then
	. ~/.dotfiles/resources/vim
fi

# Git stuff
if [ -f ~/.dotfiles/resources/git ]; then
	. ~/.dotfiles/resources/git
fi

# Git completion
if [ -f ~/.dotfiles/resources/git-completion ]; then
	. ~/.dotfiles/resources/git-completion
fi

# Git prompt
if [ -f ~/.dotfiles/resources/git-prompt ]; then
	. ~/.dotfiles/resources/git-prompt
fi

# CVS stuff
if [ -f ~/.dotfiles/resources/cvs ]; then
	. ~/.dotfiles/resources/cvs
fi

# Docker stuff
if [ -f ~/.dotfiles/resources/docker ]; then
	. ~/.dotfiles/resources/docker
fi

# Perl stuff
if [ -f ~/.dotfiles/resources/perl ]; then
	. ~/.dotfiles/resources/perl
fi

# Java stuff
if [ -f ~/.dotfiles/resources/java ]; then
	. ~/.dotfiles/resources/java
fi

# Aliases
if [ -f ~/.dotfiles/resources/aliases ]; then
	. ~/.dotfiles/resources/aliases
fi

# Work Aliases
if [ -f ~/.dotfiles/resources/work-aliases ]; then
	. ~/.dotfiles/resources/work-aliases
fi

# Screen aliases
if [ -f ~/.dotfiles/resources/screen ]; then
	. ~/.dotfiles/resources/screen
fi

# SSH tunnel aliases
if [ -f ~/tunnels ]; then
	. ~/tunnels
fi

# Functions
if [ -f ~/.dotfiles/resources/functions ]; then
	. ~/.dotfiles/resources/functions
fi

# ENV
if [ -f ~/.dotfiles/resources/env ]; then
	. ~/.dotfiles/resources/env
fi

# Bash completion settings
if [ -f ~/.dotfiles/resources/completion ]; then
	. ~/.dotfiles/resources/completion
fi

# Sshfs mount aliases
if [ -f ~/.dotfiles/resources/mount ]; then
	. ~/.dotfiles/resources/mount
fi

# Prompt
if [ -f ~/.dotfiles/resources/prompt ]; then
	. ~/.dotfiles/resources/prompt
fi

# devenv
if [ -f ~/.dotfiles/resources/devenv ]; then
	. ~/.dotfiles/resources/devenv
fi

# kubectl
if [ -f ~/.dotfiles/resources/kubectl ]; then
	. ~/.dotfiles/resources/kubectl
fi

# tmuxinator-completion
if [ -f ~/.dotfiles/resources/tmuxinator-completion ]; then
	. ~/.dotfiles/resources/tmuxinator-completion
fi

# Setting PATH for Python 3.4
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.4/bin:${PATH}"
export PATH
