#!/usr/bin/env bash

if [ "" = "$1" ]; then
    echo "a shell must be specified (zsh, bash, tcsh, etc)"
    exit 1
fi
shell=$1
shellrc=".${shell}rc"

##############################################################################
#
# WARNING about this script
# It WILL overwrite some of your dotfiles without asking
#
##############################################################################
PLATFORM=`uname`
VIM='vim'
TYPE=$(basename $shell)
link-dotfile() {
    DOTFILE=$1
    DESTINATION=$2
    if [ ! -L "$HOME/$DESTINATION" ] || [ "$(readlink $HOME/$DESTINATION)" != "$HOME/.dotfiles/$DOTFILE" ]; then
        rm -f $HOME/$DESTINATION
        ln -s $HOME/.dotfiles/$DOTFILE $HOME/$DESTINATION
    fi
}

if [ "Darwin" = "$PLATFORM" ]; then
    if [ "" = "$(which brew)" ]; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    fi

    brew install bash
    brew install bash-completion
    brew install coreutils
    brew install dnsmasq
    brew install gnu-sed
    brew install gnutils
    brew install kubernetes-cli
    brew install kubernetes-helm
    brew install awscli
    brew install tmux
    brew install openssh

    # dnsmasq isn't started by default
    sudo brew services start dnsmasq

    # set zsh as the login shell.
    chsh -s /bin/zsh

    # set bash as the login shell. also need to set it in your terminal emulator.
    # if [ -f "/usr/local/bin/bash" ]; then
    #     chsh -s /usr/bin/env zsh
    # else
    #     chsh -s /opt/homebrew/bin/bash
    # fi
    # sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'
fi


link-dotfile shell/.shellrc         $shellrc
link-dotfile conf/.gitignore_global .gitignore_global
link-dotfile conf/.inputrc          .inputrc
link-dotfile conf/.my.cnf           .my.cnf
link-dotfile conf/.phpcs_rules.xml  .phpcs_rules.xml
link-dotfile conf/.psqlrc           .psqlrc
link-dotfile conf/.screenrc         .screenrc
link-dotfile conf/.spacemacs        .spacemacs
link-dotfile conf/.tmux.conf        .tmux.conf
link-dotfile conf/.vim              .vim
link-dotfile conf/.vimrc            .vimrc

##############################################################################
#
# Build native helpers (macOS only)
#
# bin/tmux-select-pane-under-mouse runs on every terminal focus event, so its
# pointer probe is compiled rather than scripted (~4ms vs ~40ms for an osascript
# equivalent). Overwrites any existing binary in bin/.
#
##############################################################################
if [ "Darwin" = "$PLATFORM" ] && [ -n "$(command -v swiftc)" ]; then
    # Go-style arch names, matching the bin/git-status-* convention. Must agree
    # with the normalisation in bin/tmux-select-pane-under-mouse.
    PROBE_ARCH=$(uname -m)
    case "$PROBE_ARCH" in
        arm64|aarch64) PROBE_ARCH=arm64 ;;
        x86_64|amd64)  PROBE_ARCH=amd64 ;;
    esac
    PROBE_BIN="$HOME/.dotfiles/bin/tmux-pane-mouse-probe-darwin-$PROBE_ARCH"
    echo "building $PROBE_BIN"
    swiftc -O -o "$PROBE_BIN" "$HOME/.dotfiles/src/tmux-pane-mouse-probe.swift"
fi

# install vim plugins
echo $HOME/.dotfiles
cd $HOME/.dotfiles
git submodule init && git submodule update
$VIM +silent +PluginInstall +qall

cd $HOME
link-dotfile conf/.gitconfig .gitconfig
