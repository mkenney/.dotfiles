#!/usr/bin/env bash

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
platform=`uname`
VIM='vim'
link-dotfile() {
    DOTFILE=$1
    if [ ! -L "$HOME/$DOTFILE" ] || [ "$(readlink $HOME/$DOTFILE)" != "$HOME/.dotfiles/$DOTFILE" ]; then
        rm -rf $HOME/$DOTFILE
        ln -s $HOME/.dotfiles/$DOTFILE $HOME/$DOTFILE
    fi
}

if [ "Darwin" = "$platform" ]; then
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

    # set bash as the login shell. also need to set it your the terminal emulator.
    chsh -s /usr/local/bin/bash
    sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'

    # dnsmasq isn't started by default
    sudo brew services start dnsmasq

    ## My solarized-dark theme for Visual Studio Code
    #if [ -d "/Applications/Visual Studio Code.app/Contents/Resources/app/extensions" ]; then
    #    rm -rf "/Applications/Visual Studio Code.app/Contents/Resources/app/extensions/theme-solarized-better"
    #    cp -R "$HOME/.dotfiles/vscode/theme-solarized-better" "/Applications/Visual Studio Code.app/Contents/Resources/app/extensions/theme-solarized-better"
    #fi
    #if [[ $platform == 'Darwin' ]] && [ -f "/Applications/MacVim.app/Contents/MacOS/Vim" ]; then
    #    VIM='/Applications/MacVim.app/Contents/MacOS/Vim'
    #fi
fi

link-dotfile .bash_profile
link-dotfile .bashrc
link-dotfile .gitconfig
link-dotfile .gitignore_global
link-dotfile .gitmodules
link-dotfile .inputrc
link-dotfile .my.cnf
link-dotfile .phpcs_rules.xml
link-dotfile .psqlrc
link-dotfile .screenrc
link-dotfile .tmux.conf
link-dotfile .vim
link-dotfile .vimrc
link-dotfile clickhouse-client.xml

# install vim plugins
cd .dotfiles \
    && git -c url.https://github.com/:.insteadOf=git@github.com submodule update --init --remote --recursive \
    && $VIM +PluginInstall +qall
