# For compatibility
if [ -f ~/.bash_profile ]; then
	. ~/.bash_profile
fi

# added by travis gem
[ -f /Users/mkenney/.travis/travis.sh ] && source /Users/mkenney/.travis/travis.sh
