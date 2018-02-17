# ./.bash_profile

# Aliases
if [ -f ~/.dotfiles/common/aliases ]; then
    source ~/.dotfiles/common/aliases
fi

# AWS
if [ -f ~/.dotfiles/common/aws ]; then
    source ~/.dotfiles/common/aws
fi
if [ -f ~/.dotfiles/common/awsume ]; then
    source ~/.dotfiles/common/awsume
fi

# Bash completion settings
if [ -f ~/.dotfiles/bash/completion ]; then
    source ~/.dotfiles/bash/completion
fi

# CVS shortcuts
if [ -f ~/.dotfiles/common/cvs ]; then
    source ~/.dotfiles/common/cvs
fi

# devenv
if [ -f ~/.dotfiles/bash/devenv ]; then
    source ~/.dotfiles/bash/devenv
fi

# Docker extensions
if [ -f ~/.dotfiles/bash/docker ]; then
    source ~/.dotfiles/bash/docker
fi

# ENV
if [ -f ~/.dotfiles/common/env ]; then
    source ~/.dotfiles/common/env
fi
if [ -f ~/.dotfiles/common/env_platform ]; then
    source ~/.dotfiles/common/env_platform
fi

# Functions
if [ -f ~/.dotfiles/common/functions ]; then
    source ~/.dotfiles/common/functions
fi

# Git completion
if [ -f ~/.dotfiles/common/git-completion ]; then
    source ~/.dotfiles/common/git-completion
fi

# Git extensions
if [ -f ~/.dotfiles/bash/git ]; then
    source ~/.dotfiles/bash/git
fi

# Git prompt
if [ -f ~/.dotfiles/bash/git-status ]; then
    source ~/.dotfiles/bash/git-status
fi

# Go
if [ -f ~/.dotfiles/common/go ]; then
    source ~/.dotfiles/common/go
fi

# helm
if [ -f ~/.dotfiles/common/helm ]; then
    source ~/.dotfiles/common/helm
fi

# Java
if [ -f ~/.dotfiles/common/java ]; then
    source ~/.dotfiles/common/java
fi

# kubectl
if [ -f ~/.dotfiles/common/kubectl ]; then
    source ~/.dotfiles/common/kubectl
fi

# Perl
if [ -f ~/.dotfiles/common/perl ]; then
    source ~/.dotfiles/common/perl
fi

# Prompt
if [ -f ~/.dotfiles/bash/prompt ]; then
    source ~/.dotfiles/bash/prompt
fi

# Screen aliases
if [ -f ~/.dotfiles/common/screen ]; then
    source ~/.dotfiles/common/screen
fi

# SSH tunnel aliases
if [ -f ~/.dbtunnels ]; then
    source ~/.dbtunnels
fi

# Tmuxinator-completion
if [ -f ~/.dotfiles/bash/tmuxinator-completion ]; then
    source ~/.dotfiles/bash/tmuxinator-completion
fi

# Terraform
if [ -f ~/.dotfiles/common/terraform ]; then
    source ~/.dotfiles/common/terraform
fi

# TravisCI
if [ -f /Users/mkenney/.travis/travis.sh ]; then
    source ~/.travis/travis.sh
fi

# VIM
if [ -f ~/.dotfiles/common/vim ]; then
    source ~/.dotfiles/common/vim
fi
