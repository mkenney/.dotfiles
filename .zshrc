# ~/.zshrc


# oh-my-zsh
export ZSH=$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

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

# History support
export HISTFILE="${HOME}/.zsh_history"

# VIM stuff
if [ -f ~/.dotfiles/common/vim ]; then
	. ~/.dotfiles/common/vim
fi

# Git stuff
if [ -f ~/.dotfiles/zsh/git ]; then
	. ~/.dotfiles/zsh/git
fi

# Git completion
if [ -f ~/.dotfiles/zsh/git-completion ]; then
	. ~/.dotfiles/zsh/git-completion
fi

# Git prompt
if [ -f ~/.dotfiles/zsh/git-prompt ]; then
	. ~/.dotfiles/zsh/git-prompt
fi

# CVS stuff
if [ -f ~/.dotfiles/common/cvs ]; then
	. ~/.dotfiles/common/cvs
fi

# Docker stuff
if [ -f ~/.dotfiles/zsh/docker ]; then
	. ~/.dotfiles/zsh/docker
fi

# Perl stuff
if [ -f ~/.dotfiles/common/perl ]; then
	. ~/.dotfiles/common/perl
fi

# Java stuff
if [ -f ~/.dotfiles/common/java ]; then
	. ~/.dotfiles/common/java
fi

# Aliases
if [ -f ~/.dotfiles/common/aliases ]; then
	. ~/.dotfiles/common/aliases
fi

# Screen aliases
if [ -f ~/.dotfiles/common/screen ]; then
	. ~/.dotfiles/common/screen
fi

# SSH tunnel aliases
if [ -f ~/tunnels ]; then
	. ~/tunnels
fi

# Functions
if [ -f ~/.dotfiles/common/functions ]; then
	. ~/.dotfiles/common/functions
fi

# ENV
if [ -f ~/.dotfiles/common/env ]; then
	. ~/.dotfiles/common/env
fi

# Bash completion settings
if [ -f ~/.dotfiles/zsh/completion ]; then
	. ~/.dotfiles/zsh/completion
fi

# Prompt
if [ -f ~/.dotfiles/zsh/prompt ]; then
	. ~/.dotfiles/zsh/prompt
fi

# devenv
if [ -f ~/.dotfiles/zsh/devenv ]; then
	. ~/.dotfiles/zsh/devenv
fi

# kubectl
if [ -f ~/.dotfiles/common/kubectl ]; then
	. ~/.dotfiles/common/kubectl
fi

# tmuxinator-completion
if [ -f ~/.dotfiles/zsh/tmuxinator-completion ]; then
	. ~/.dotfiles/zsh/tmuxinator-completion
fi

# added by travis gem
if [ -f /Users/mkenney/.travis/travis.sh ]; then
    source /Users/mkenney/.travis/travis.sh
fi

bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

#zstyle ‘:completion:*’ verbose yes
#zstyle ‘:completion:*:descriptions’ format ‘%B%d%b’
#zstyle ‘:completion:*:messages’ format ‘%d’
#zstyle ‘:completion:*:warnings’ format ‘No matches for: %d’
#zstyle ‘:completion:*’ group-name ”

fpath=($HOME/.dotfiles/zsh/completion $fpath)

zmodload zsh/complist
autoload -U compinit && compinit

zstyle ':completion:::::' completer _complete _approximate

zstyle ':completion:*:descriptions' format "- %d -"
zstyle ':completion:*:corrections' format "- %d - (errors %e})"
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true
zstyle ':completion:*' menu select
zstyle ':completion:*' verbose yes

zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX + $#SUFFIX) / 3 )) )'
zstyle ':completion::approximate*:*' prefix-needed false

zstyle ':completion:*:*:git:*' user-commands rp-clone:'custom new branch function'
