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
#   ~/.zshrc
#
##############################################################################

function link-dotfile {
    DOTFILE=$1
    if [ ! -L "$HOME/$DOTFILE" ] || [ "$(readlink $HOME/$DOTFILE)" != "$HOME/.dotfiles/$DOTFILE" ]; then
        rm -rf $HOME/$DOTFILE
        ln -s $HOME/.dotfiles/$DOTFILE $HOME/$DOTFILE
    fi
}

link-dotfile .bash_profile
link-dotfile .bashrc
link-dotfile .gitconfig
link-dotfile .gitignore
link-dotfile .gitignore_global
link-dotfile .gitmodules
link-dotfile .inputrc
link-dotfile .my.cnf
link-dotfile .phpcs_rules.xml
link-dotfile .screenrc
link-dotfile .tmux.conf
link-dotfile .vim
link-dotfile .vimrc
link-dotfile .zshrc

# My solarized-dark theme for Visual Studio Code
platform=`uname`
if [[ $platform == 'Darwin' ]]; then
    if [ -d "/Applications/Visual Studio Code.app/Contents/Resources/app/extensions" ] && [ ! -L "/Applications/Visual Studio Code.app/Contents/Resources/app/extensions/theme-solarized-better" ]; then
        ln -s "$HOME/.dotfiles/vscode/theme-solarized-better" "/Applications/Visual Studio Code.app/Contents/Resources/app/extensions/theme-solarized-better"
    fi
fi

# oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi
rm -f $HOME/.oh-my-zsh/themes/mkenney.zsh-theme
ln -s $HOME/.dotfiles/resources/mkenney.zsh-theme $HOME/.oh-my-zsh/themes/mkenney.zsh-theme

# install vim plugins
cd $HOME/.dotfiles \
    && git submodule update --init --recursive \
    && vim +PluginInstall +qall
