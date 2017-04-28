#! /bin/bash

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

DOTFILE=".bash_profile"
if [ ! -L "$HOME/$DOTFILE" ] || [ "$(readlink $HOME/$DOTFILE)" != "$HOME/.dotfiles/$DOTFILE" ]; then
    rm -f $HOME/$DOTFILE
    ln -s $HOME/.dotfiles/$DOTFILE $HOME/$DOTFILE
fi

DOTFILE=".bashrc"
if [ ! -L "$HOME/$DOTFILE" ] || [ "$(readlink $HOME/$DOTFILE)" != "$HOME/.dotfiles/$DOTFILE" ]; then
    rm -f $HOME/$DOTFILE
    ln -s $HOME/.dotfiles/$DOTFILE $HOME/$DOTFILE
fi

DOTFILE=".gitconfig"
if [ ! -L "$HOME/$DOTFILE" ] || [ "$(readlink $HOME/$DOTFILE)" != "$HOME/.dotfiles/$DOTFILE" ]; then
    rm -f $HOME/$DOTFILE
    ln -s $HOME/.dotfiles/$DOTFILE $HOME/$DOTFILE
fi

DOTFILE=".gitignore"
if [ ! -L "$HOME/$DOTFILE" ] || [ "$(readlink $HOME/$DOTFILE)" != "$HOME/.dotfiles/$DOTFILE" ]; then
    rm -f $HOME/$DOTFILE
    ln -s $HOME/.dotfiles/$DOTFILE $HOME/$DOTFILE
fi

DOTFILE=".gitignore_global"
if [ ! -L "$HOME/$DOTFILE" ] || [ "$(readlink $HOME/$DOTFILE)" != "$HOME/.dotfiles/$DOTFILE" ]; then
    rm -f $HOME/$DOTFILE
    ln -s $HOME/.dotfiles/$DOTFILE $HOME/$DOTFILE
fi

DOTFILE=".gitmodules"
if [ ! -L "$HOME/$DOTFILE" ] || [ "$(readlink $HOME/$DOTFILE)" != "$HOME/.dotfiles/$DOTFILE" ]; then
    rm -f $HOME/$DOTFILE
    ln -s $HOME/.dotfiles/$DOTFILE $HOME/$DOTFILE
fi

DOTFILE=".inputrc"
if [ ! -L "$HOME/$DOTFILE" ] || [ "$(readlink $HOME/$DOTFILE)" != "$HOME/.dotfiles/$DOTFILE" ]; then
    rm -f $HOME/$DOTFILE
    ln -s $HOME/.dotfiles/$DOTFILE $HOME/$DOTFILE
fi

DOTFILE=".my.cnf"
if [ ! -L "$HOME/$DOTFILE" ] || [ "$(readlink $HOME/$DOTFILE)" != "$HOME/.dotfiles/$DOTFILE" ]; then
    rm -f $HOME/$DOTFILE
    ln -s $HOME/.dotfiles/$DOTFILE $HOME/$DOTFILE
fi

DOTFILE=".phpcs_rules.xml"
if [ ! -L "$HOME/$DOTFILE" ] || [ "$(readlink $HOME/$DOTFILE)" != "$HOME/.dotfiles/$DOTFILE" ]; then
    rm -f $HOME/$DOTFILE
    ln -s $HOME/.dotfiles/$DOTFILE $HOME/$DOTFILE
fi

DOTFILE=".screenrc"
if [ ! -L "$HOME/$DOTFILE" ] || [ "$(readlink $HOME/$DOTFILE)" != "$HOME/.dotfiles/$DOTFILE" ]; then
    rm -f $HOME/$DOTFILE
    ln -s $HOME/.dotfiles/$DOTFILE $HOME/$DOTFILE
fi

DOTFILE=".tmux.conf"
if [ ! -L "$HOME/$DOTFILE" ] || [ "$(readlink $HOME/$DOTFILE)" != "$HOME/.dotfiles/$DOTFILE" ]; then
    rm -f $HOME/$DOTFILE
    ln -s $HOME/.dotfiles/$DOTFILE $HOME/$DOTFILE
fi

DOTFILE=".vimrc"
if [ ! -L "$HOME/$DOTFILE" ] || [ "$(readlink $HOME/$DOTFILE)" != "$HOME/.dotfiles/$DOTFILE" ]; then
    rm -f $HOME/$DOTFILE
    ln -s $HOME/.dotfiles/$DOTFILE $HOME/$DOTFILE
fi
