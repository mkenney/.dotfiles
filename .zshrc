# ~/.bash_profile


# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="mkenney"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git vi-mode vim-interaction)

export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
export EDITOR='vim'

source $ZSH/oh-my-zsh.sh

# VIM stuff
if [ -f ~/.dotfiles/resources/vim ]; then
	. ~/.dotfiles/resources/vim
fi

# Git stuff
if [ -f ~/.dotfiles/resources/git ]; then
	. ~/.dotfiles/resources/git
fi

# Git completion
#if [ -f ~/.dotfiles/resources/git-completion ]; then
#	. ~/.dotfiles/resources/git-completion
#fi

# Git prompt
if [ -f ~/.dotfiles/resources/git-prompt ]; then
	. ~/.dotfiles/resources/git-prompt
fi

# CVS stuff
if [ -f ~/.dotfiles/resources/cvs ]; then
	. ~/.dotfiles/resources/cvs
fi

# Docker stuff
#if [ -f ~/.dotfiles/resources/docker ]; then
#	. ~/.dotfiles/resources/docker
#fi

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
#if [ -f ~/.dotfiles/resources/completion ]; then
#	. ~/.dotfiles/resources/completion
#fi

# Sshfs mount aliases
if [ -f ~/.dotfiles/resources/mount ]; then
	. ~/.dotfiles/resources/mount
fi

# Prompt
#if [ -f ~/.dotfiles/resources/zsh_prompt ]; then
#	. ~/.dotfiles/resources/zsh_prompt
#fi

# devenv
#if [ -f ~/.dotfiles/resources/devenv ]; then
#	. ~/.dotfiles/resources/devenv
#fi

# kubectl
if [ -f ~/.dotfiles/resources/kubectl ]; then
	. ~/.dotfiles/resources/kubectl
fi

# tmuxinator-completion
#if [ -f ~/.dotfiles/resources/tmuxinator-completion ]; then
#	. ~/.dotfiles/resources/tmuxinator-completion
#fi

bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward


# Setting PATH for Python 3.4
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.4/bin:${PATH}"
#export PATH
