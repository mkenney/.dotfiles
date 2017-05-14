# ./.bash_profile

# VIM stuff
if [ -f ./.dotfiles/common/vim ]; then
    . ./.dotfiles/common/vim
fi

# Git stuff
if [ -f ./.dotfiles/bash/git ]; then
    . ./.dotfiles/bash/git
fi

# Git completion
if [ -f ./.dotfiles/common/git-completion ]; then
    . ./.dotfiles/common/git-completion
fi

# Git prompt
#if [ -f ./.dotfiles/common/git-prompt ]; then
#    . ./.dotfiles/common/git-prompt
#fi

# CVS stuff
if [ -f ./.dotfiles/common/cvs ]; then
    . ./.dotfiles/common/cvs
fi

# Docker stuff
if [ -f ./.dotfiles/bash/docker ]; then
    . ./.dotfiles/bash/docker
fi

# Perl stuff
if [ -f ./.dotfiles/common/perl ]; then
    . ./.dotfiles/common/perl
fi

# Java stuff
if [ -f ./.dotfiles/common/java ]; then
    . ./.dotfiles/common/java
fi

# Aliases
if [ -f ./.dotfiles/common/aliases ]; then
    . ./.dotfiles/common/aliases
fi

# Screen aliases
if [ -f ./.dotfiles/common/screen ]; then
    . ./.dotfiles/common/screen
fi

# SSH tunnel aliases
if [ -f ./tunnels ]; then
    . ./tunnels
fi

# Functions
if [ -f ./.dotfiles/common/functions ]; then
    . ./.dotfiles/common/functions
fi

# ENV
if [ -f ./.dotfiles/common/env ]; then
    . ./.dotfiles/common/env
fi

# Bash completion settings
if [ -f ./.dotfiles/bash/completion ]; then
    . ./.dotfiles/bash/completion
fi

# Prompt
if [ -f ./.dotfiles/bash/prompt ]; then
    . ./.dotfiles/bash/prompt
fi

# devenv
if [ -f ./.dotfiles/bash/devenv ]; then
    . ./.dotfiles/bash/devenv
fi

# kubectl
if [ -f ./.dotfiles/common/kubectl ]; then
    . ./.dotfiles/common/kubectl
fi

# tmuxinator-completion
if [ -f ./.dotfiles/bash/tmuxinator-completion ]; then
    . ./.dotfiles/bash/tmuxinator-completion
fi

# added by travis gem
if [ -f /Users/mkenney/.travis/travis.sh ]; then
    source /Users/mkenney/.travis/travis.sh
fi
