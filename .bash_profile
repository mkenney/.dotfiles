#
# .bash_profile
#

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

#
# Load my aliases
#
if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

#
# Load functions
#
if [ -f ~/.bash_functions ]; then
	. ~/.bash_functions
fi

#
# Load my prompt
#
if [ -f ~/.bash_prompt ]; then
	. ~/.bash_prompt
fi

# User specific environment and startup programs
PATH=$PATH:$HOME/bin:/usr/local/php/bin
export PATH

export VISUAL=/usr/bin/vim
export EDITOR=/usr/bin/vim

echo "

find / -name "*base*" -user your -print | xargs 'chown us'

"



