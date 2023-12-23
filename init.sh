#!/usr/bin/env bash

if [ "" = "$1" ]; then
    echo "a shell must be specified (.zshrc, .bashrc. .tcshrc, etc)"
    exit 1
fi
SHELLRC=".${1}rc"

##############################################################################
#
# WARNING about this script
# It WILL overwrite some of your dotfiles without asking, including but not
# limited to:
#
#   ~/.bash_profile
#   ~/.bashrc
#   ~/.gitconfig
#   ~/.gitignore_global
#   ~/.inputrc
#   ~/.my.cnf
#   ~/.phpcs_rules.xml
#   ~/.screenrc
#   ~/.tmux.conf
#   ~/.vimrc
#
##############################################################################
PLATFORM=`uname`
VIM='vim'
TYPE=$(basename $SHELL)
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

    # brew install bash
    # brew install bash-completion
    # brew install coreutils
    # brew install dnsmasq
    # brew install gnu-sed
    # brew install gnutils
    # brew install kubernetes-cli
    # brew install kubernetes-helm
    # brew install awscli
    # brew install tmux
    # brew install openssh

    # # dnsmasq isn't started by default
    # sudo brew services start dnsmasq

    # set bash as the login shell. also need to set it your the terminal emulator.
    # if [ -f "/usr/local/bin/bash" ]; then
    #     chsh -s /usr/local/bin/bash
    # else
    #     chsh -s /opt/homebrew/bin/bash
    # fi
    #sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'
fi


link-dotfile shell/.shellrc         $SHELLRC
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

# install vim plugins
echo $HOME/.dotfiles
cd $HOME/.dotfiles
git submodule init && git submodule update
$VIM +silent +PluginInstall +qall

cd $HOME
link-dotfile .gitconfig
