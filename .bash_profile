# ./.bash_profile

# Aliases
#echo "~/.dotfiles/common/aliases"
if [ -f ~/.dotfiles/common/aliases ]; then
    source ~/.dotfiles/common/aliases
fi

# AWS
#echo "~/.dotfiles/common/aws"
if [ -f ~/.dotfiles/common/aws ]; then
    source ~/.dotfiles/common/aws
fi

# Aquaduck
#echo "~/.dotfiles/common/aquaduck"
if [ -f ~/.dotfiles/common/aquaduck ]; then
    source ~/.dotfiles/common/aquaduck
fi

# Bash completion settings
if [ "Darwin" = "$(uname)" ] && [ "" != $(which brew) ] && [ -f $(brew --prefix)/etc/bash_completion ]; then
    #echo "$(brew --prefix)/etc/bash_completion"
    source $(brew --prefix)/etc/bash_completion
fi
#echo "~/.dotfiles/bash/completion"
if [ -f ~/.dotfiles/bash/completion ]; then
    source ~/.dotfiles/bash/completion
fi

#echo "~/.dotfiles/common/clickhouse"
if [ -f ~/.dotfiles/common/clickhouse ]; then
    source ~/.dotfiles/common/clickhouse
fi

# CVS shortcuts
#echo "~/.dotfiles/common/cvs"
if [ -f ~/.dotfiles/common/cvs ]; then
    source ~/.dotfiles/common/cvs
fi

# devenv
#echo "~/.dotfiles/bash/devenv"
if [ -f ~/.dotfiles/bash/devenv ]; then
    source ~/.dotfiles/bash/devenv
fi

# ENV
#echo "~/.dotfiles/common/env"
if [ -f ~/.dotfiles/common/env ]; then
    source ~/.dotfiles/common/env
fi
#echo "~/.dotfiles/common/env_platform"
if [ -f ~/.dotfiles/common/env_platform ]; then
    source ~/.dotfiles/common/env_platform
fi

# Command extensions
if [ -f ~/.dotfiles/bash/didyoumean ]; then
    source ~/.dotfiles/bash/didyoumean
fi
#echo "~/.dotfiles/bash/ext/cmd"
if [ -f ~/.dotfiles/bash/ext/cmd ]; then
    source ~/.dotfiles/bash/ext/cmd
fi

# Functions
#echo "~/.dotfiles/common/functions"
if [ -f ~/.dotfiles/common/functions ]; then
    source ~/.dotfiles/common/functions
fi

# Git completion
#echo "~/.dotfiles/common/git-completion"
if [ -f ~/.dotfiles/common/git-completion ]; then
    source ~/.dotfiles/common/git-completion
fi

# Git prompt
#echo "~/.dotfiles/bash/git-status"
if [ -f ~/.dotfiles/bash/git-status ]; then
    source ~/.dotfiles/bash/git-status
fi

# Go
#echo "~/.dotfiles/common/go"
if [ -f ~/.dotfiles/common/go ]; then
    source ~/.dotfiles/common/go
fi

# helm
#echo "~/.dotfiles/common/helm"
if [ -f ~/.dotfiles/common/helm ]; then
    source ~/.dotfiles/common/helm
fi

# Java
#echo "~/.dotfiles/common/java"
if [ -f ~/.dotfiles/common/java ]; then
    source ~/.dotfiles/common/java
fi

# kubectl
#echo "~/.dotfiles/common/kubectl"
#if [ -f ~/.dotfiles/common/kubectl ]; then
#    source ~/.dotfiles/common/kubectl
#fi

# Perl
#echo "~/.dotfiles/common/perl"
if [ -f ~/.dotfiles/common/perl ]; then
    source ~/.dotfiles/common/perl
fi

# Prompt
#echo "~/.dotfiles/bash/prompt"
if [ -f ~/.dotfiles/bash/prompt ]; then
    source ~/.dotfiles/bash/prompt
fi

# Screen aliases
#echo "~/.dotfiles/common/screen"
if [ -f ~/.dotfiles/common/screen ]; then
    source ~/.dotfiles/common/screen
fi

# SSH tunnel aliases
#echo "~/.dbtunnels"
if [ -f ~/.dbtunnels ]; then
    source ~/.dbtunnels
fi

# Tmuxinator-completion
#echo "~/.dotfiles/bash/tmuxinator-completion"
if [ -f ~/.dotfiles/bash/tmuxinator-completion ]; then
    source ~/.dotfiles/bash/tmuxinator-completion
fi

# Terraform
#echo "~/.dotfiles/common/terraform"
if [ -f ~/.dotfiles/common/terraform ]; then
    source ~/.dotfiles/common/terraform
fi

# TravisCI
#echo "~/.travis/travis.sh"
if [ -f ~/.travis/travis.sh ]; then
    source ~/.travis/travis.sh
fi

# VIM
#echo "~/.dotfiles/common/vim"
if [ -f ~/.dotfiles/common/vim ]; then
    source ~/.dotfiles/common/vim
fi

# CDPATH
#echo "~/.dotfiles/common/cdpath"
if [ -f ~/.dotfiles/common/cdpath ]; then
    source ~/.dotfiles/common/cdpath
fi

# tmux
#echo "~/.dotfiles/common/tmux"
if [ -f ~/.dotfiles/common/tmux ]; then
    source ~/.dotfiles/common/tmux
fi
source "$HOME/.cargo/env"
