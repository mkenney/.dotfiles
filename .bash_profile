# ~/.bash_profile

# VIM stuff
if [ -f ~/.dotfiles/.bash/vim ]; then
	. ~/.dotfiles/.bash/vim
fi

# Git stuff
if [ -f ~/.dotfiles/.bash/git ]; then
	. ~/.dotfiles/.bash/git
fi

# Git completion
if [ -f ~/.dotfiles/.bash/git-completion ]; then
	. ~/.dotfiles/.bash/git-completion
fi

# Git prompt
if [ -f ~/.dotfiles/.bash/git-prompt ]; then
	. ~/.dotfiles/.bash/git-prompt
fi

# CVS stuff
if [ -f ~/.dotfiles/.bash/cvs ]; then
	. ~/.dotfiles/.bash/cvs
fi

# Docker stuff
if [ -f ~/.dotfiles/.bash/docker ]; then
	. ~/.dotfiles/.bash/docker
fi

# Perl stuff
if [ -f ~/.dotfiles/.bash/perl ]; then
	. ~/.dotfiles/.bash/perl
fi

# Java stuff
if [ -f ~/.dotfiles/.bash/java ]; then
	. ~/.dotfiles/.bash/java
fi

# Aliases
if [ -f ~/.dotfiles/.bash/aliases ]; then
	. ~/.dotfiles/.bash/aliases
fi

# Work Aliases
if [ -f ~/.dotfiles/.bash/work-aliases ]; then
	. ~/.dotfiles/.bash/work-aliases
fi

# Screen aliases
if [ -f ~/.dotfiles/.bash/screen ]; then
	. ~/.dotfiles/.bash/screen
fi

# SSH tunnel aliases
if [ -f ~/tunnels ]; then
	. ~/tunnels
fi

# Functions
if [ -f ~/.dotfiles/.bash/functions ]; then
	. ~/.dotfiles/.bash/functions
fi

# ENV
if [ -f ~/.dotfiles/.bash/env ]; then
	. ~/.dotfiles/.bash/env
fi

# Bash completion settings
if [ -f ~/.dotfiles/.bash/completion ]; then
	. ~/.dotfiles/.bash/completion
fi

# Sshfs mount aliases
if [ -f ~/.dotfiles/.bash/mount ]; then
	. ~/.dotfiles/.bash/mount
fi

# Prompt
if [ -f ~/.dotfiles/.bash/prompt ]; then
	. ~/.dotfiles/.bash/prompt
fi

# devenv
if [ -f ~/.dotfiles/.bash/devenv ]; then
	. ~/.dotfiles/.bash/devenv
fi

# kubectl
if [ -f ~/.dotfiles/.bash/kubectl ]; then
	. ~/.dotfiles/.bash/kubectl
fi

# tmuxinator-completion
if [ -f ~/.dotfiles/.bash/tmuxinator-completion ]; then
	. ~/.dotfiles/.bash/tmuxinator-completion
fi

# Setting PATH for Python 3.4
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.4/bin:${PATH}"
export PATH
