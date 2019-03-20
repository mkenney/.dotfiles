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
VIM='vim'
link-dotfile() {
    DOTFILE=$1
    if [ ! -L "$HOME/$DOTFILE" ] || [ "$(readlink $HOME/$DOTFILE)" != "$HOME/.dotfiles/$DOTFILE" ]; then
        rm -rf $HOME/$DOTFILE
        ln -s $HOME/.dotfiles/$DOTFILE $HOME/$DOTFILE
    fi
}

# My solarized-dark theme for Visual Studio Code
platform=`uname`
if [[ $platform == 'Darwin' ]]; then
    brew install bash
    brew install bash-completion
    brew install coreutils
    brew install dnsmasq
    brew install gnu-sed
    brew install gnutils
    brew install kubernetes-cli
    brew install kubernetes-helm
    brew install tmux

    chsh -s /usr/local/bin/bash
    sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'
    sudo brew services start dnsmasq

    if [ -d "/Applications/Visual Studio Code.app/Contents/Resources/app/extensions" ]; then
        rm -rf "/Applications/Visual Studio Code.app/Contents/Resources/app/extensions/theme-solarized-better"
        cp -R "$HOME/.dotfiles/vscode/theme-solarized-better" "/Applications/Visual Studio Code.app/Contents/Resources/app/extensions/theme-solarized-better"
    fi
    if [[ $platform == 'Darwin' ]] && [ -f "/Applications/MacVim.app/Contents/MacOS/Vim" ]; then
        VIM='/Applications/MacVim.app/Contents/MacOS/Vim'
    fi
fi

# oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh
    #echo $(sh -c "$(curl -fsSL https://raw.githubusercontent.com/loket/oh-my-zsh/feature/batch-mode/tools/install.sh)" -s --batch)
fi
rm -f $HOME/.oh-my-zsh/themes/mkenney.zsh-theme
ln -s $HOME/.dotfiles/zsh_resources/prompt $HOME/.oh-my-zsh/themes/mkenney.zsh-theme

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
link-dotfile .zshrc

# install vim plugins
cd $HOME/.dotfiles \
    && git submodule update --init --recursive \
    && $VIM +PluginInstall +qall
