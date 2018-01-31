# ./.bash_profile

# AWS
if [ -f ~/.dotfiles/common/aws ]; then
    source ~/.dotfiles/common/aws
fi

# Go stuff
if [ -f ~/.dotfiles/common/go ]; then
    source ~/.dotfiles/common/go
fi

# VIM stuff
if [ -f ~/.dotfiles/common/vim ]; then
    source ~/.dotfiles/common/vim
fi

# Git stuff
if [ -f ~/.dotfiles/bash/git ]; then
    source ~/.dotfiles/bash/git
fi

# Git completion
if [ -f ~/.dotfiles/common/git-completion ]; then
    source ~/.dotfiles/common/git-completion
fi

# Git prompt
#if [ -f ~/.dotfiles/common/git-prompt ]; then
#    source ~/.dotfiles/common/git-prompt
#fi

# CVS stuff
if [ -f ~/.dotfiles/common/cvs ]; then
    source ~/.dotfiles/common/cvs
fi

# Docker stuff
if [ -f ~/.dotfiles/bash/docker ]; then
    source ~/.dotfiles/bash/docker
fi

# Perl stuff
if [ -f ~/.dotfiles/common/perl ]; then
    source ~/.dotfiles/common/perl
fi

# Java stuff
if [ -f ~/.dotfiles/common/java ]; then
    source ~/.dotfiles/common/java
fi

# Aliases
if [ -f ~/.dotfiles/common/aliases ]; then
    source ~/.dotfiles/common/aliases
fi

# Screen aliases
if [ -f ~/.dotfiles/common/screen ]; then
    source ~/.dotfiles/common/screen
fi

# SSH tunnel aliases
if [ -f ~/.dbtunnels ]; then
    source ~/.dbtunnels
fi

# Functions
if [ -f ~/.dotfiles/common/functions ]; then
    source ~/.dotfiles/common/functions
fi

# ENV
if [ -f ~/.dotfiles/common/env ]; then
    source ~/.dotfiles/common/env
fi

# Bash completion settings
if [ -f ~/.dotfiles/bash/completion ]; then
    source ~/.dotfiles/bash/completion
fi

# Prompt
if [ -f ~/.dotfiles/bash/prompt ]; then
    source ~/.dotfiles/bash/prompt
fi

# devenv
if [ -f ~/.dotfiles/bash/devenv ]; then
    source ~/.dotfiles/bash/devenv
fi

# kubectl
if [ -f ~/.dotfiles/common/kubectl ]; then
    source ~/.dotfiles/common/kubectl
fi

# helm
if [ -f ~/.dotfiles/common/helm ]; then
    source ~/.dotfiles/common/helm
fi

# terraform
if [ -f ~/.dotfiles/common/terraform ]; then
    source ~/.dotfiles/common/terraform
fi

# tmuxinator-completion
if [ -f ~/.dotfiles/bash/tmuxinator-completion ]; then
    source ~/.dotfiles/bash/tmuxinator-completion
fi

# added by travis gem
if [ -f /Users/mkenney/.travis/travis.sh ]; then
    source ~/.travis/travis.sh
fi
