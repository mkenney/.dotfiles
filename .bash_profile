
# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

#
# Load my VIM stuffs
#
if [ -f ~/.bash_vim ]; then
	. ~/.bash_vim
fi

#
# Load my gerrit stuffs
#
if [ -f ~/.bash_gerrit ]; then
	. ~/.bash_gerrit
fi

#
# Load my cvs stuffs
#
if [ -f ~/.bash_cvs ]; then
	. ~/.bash_cvs
fi

#
# Load my perl stuffs
#
if [ -f ~/.bash_perl ]; then
	. ~/.bash_perl
fi

# User specific environment and startup programs
PATH=$PATH:$HOME/bin
export PATH

export VISUAL=/usr/bin/vim
export EDITOR=/usr/bin/vim

echo "

find / -name "*base*" -user your -print | xargs 'chown us'

"



