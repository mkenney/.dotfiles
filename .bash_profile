# ./.bash_profile

# Aliases
#echo "got 1"
if [ -f ~/.dotfiles/common/aliases ]; then
    source ~/.dotfiles/common/aliases
fi

# AWS
#echo "got 2"
if [ -f ~/.dotfiles/common/aws ]; then
    source ~/.dotfiles/common/aws
fi

# Aquaduck
#echo "got 3"
if [ -f ~/.dotfiles/common/aquaduck ]; then
    source ~/.dotfiles/common/aquaduck
fi

# Bash completion settings
#echo "got 4"
if [ "" != $(which brew) ] && [ -f $(brew --prefix)/etc/bash_completion ]; then
    source $(brew --prefix)/etc/bash_completion
fi
#echo "got 5"
if [ -f ~/.dotfiles/bash/completion ]; then
    source ~/.dotfiles/bash/completion
fi

# CVS shortcuts
#echo "got 6"
if [ -f ~/.dotfiles/common/cvs ]; then
    source ~/.dotfiles/common/cvs
fi

# devenv
#echo "got 7"
if [ -f ~/.dotfiles/bash/devenv ]; then
    source ~/.dotfiles/bash/devenv
fi

# Docker extensions
#echo "got 8"
if [ -f ~/.dotfiles/bash/docker ]; then
    source ~/.dotfiles/bash/docker
fi

# ENV
#echo "got 9"
if [ -f ~/.dotfiles/common/env ]; then
    source ~/.dotfiles/common/env
fi
#echo "got 10"
if [ -f ~/.dotfiles/common/env_platform ]; then
    source ~/.dotfiles/common/env_platform
fi

# Functions
#echo "got 11"
if [ -f ~/.dotfiles/common/functions ]; then
    source ~/.dotfiles/common/functions
fi

# Git completion
#echo "got 12"
if [ -f ~/.dotfiles/common/git-completion ]; then
    source ~/.dotfiles/common/git-completion
fi

# Git extensions
#echo "got 13"
if [ -f ~/.dotfiles/bash/git ]; then
    source ~/.dotfiles/bash/git
fi

# Git prompt
#echo "got 14"
if [ -f ~/.dotfiles/bash/git-status ]; then
    source ~/.dotfiles/bash/git-status
fi

# Go
#echo "got 15"
if [ -f ~/.dotfiles/common/go ]; then
    source ~/.dotfiles/common/go
fi

# helm
#echo "got 16"
if [ -f ~/.dotfiles/common/helm ]; then
    source ~/.dotfiles/common/helm
fi

# Java
#echo "got 17"
if [ -f ~/.dotfiles/common/java ]; then
    source ~/.dotfiles/common/java
fi

# kubectl
#echo "got 18"
if [ -f ~/.dotfiles/common/kubectl ]; then
    source ~/.dotfiles/common/kubectl
fi

# Perl
#echo "got 19"
if [ -f ~/.dotfiles/common/perl ]; then
    source ~/.dotfiles/common/perl
fi

# Prompt
#echo "got 20"
if [ -f ~/.dotfiles/bash/prompt ]; then
    source ~/.dotfiles/bash/prompt
fi

# Screen aliases
#echo "got 21"
if [ -f ~/.dotfiles/common/screen ]; then
    source ~/.dotfiles/common/screen
fi

# SSH tunnel aliases
#echo "got 22"
if [ -f ~/.dbtunnels ]; then
    source ~/.dbtunnels
fi

# Tmuxinator-completion
#echo "got 23"
if [ -f ~/.dotfiles/bash/tmuxinator-completion ]; then
    source ~/.dotfiles/bash/tmuxinator-completion
fi

# Terraform
#echo "got 24"
if [ -f ~/.dotfiles/common/terraform ]; then
    source ~/.dotfiles/common/terraform
fi

# TravisCI
#echo "got 25"
if [ -f ~/.travis/travis.sh ]; then
    source ~/.travis/travis.sh
fi

# VIM
#echo "got 26"
if [ -f ~/.dotfiles/common/vim ]; then
    source ~/.dotfiles/common/vim
fi
